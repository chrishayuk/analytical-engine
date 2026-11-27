#!/usr/bin/env python3
"""A local cache of Science Museum Group images, fetched once, read many times.

The images of the Babbage Papers are served only by the Science Museum
Group's IIIF server (zoom.sciencemuseumgroup.org.uk), which gives full
resolution only in 512 x 512 tiles. Each tile is fetched once, kept exactly as
the server sent it, and never fetched again:

    sources/downloads/smg/tiles/<a>-<b>/info.json
    sources/downloads/smg/tiles/<a>-<b>/<x>_<y>.jpg     (x, y: the tile's top left)

`sources/downloads/` is not committed (see sources/README.md). What is cached,
with each image's source and size, is written to sources/smg-cache.json, which
is committed.

Use from a script, to read any region at full resolution:

    import sys; sys.path.insert(0, "scripts")
    from smg_cache import crop
    img = crop("216/259/Babbage_Papers__Table_Multiplication_1836_Jan_5.ptif", 4665, 6465, 195, 80)

Fill the cache for whole images, politely (one request every DELAY seconds,
backing off on 403/429/5xx):

    python3 scripts/smg_cache.py fill [ZOOM_PATH ...]     (default: the list in DEFAULT)
    python3 scripts/smg_cache.py status
"""

import io
import json
import os
import sys
import time
import urllib.error
import urllib.parse
import urllib.request
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
CACHE = ROOT / "sources/downloads/smg/tiles"
MANIFEST = ROOT / "sources/smg-cache.json"
BASE = "https://zoom.sciencemuseumgroup.org.uk/iiif/3/"
UA = "Mozilla/5.0 (compatible; research transcription)"
TILE = 512
DELAY = float(os.environ.get("SMG_DELAY", "2.5"))

# The images the research uses: the tables of F/013-F/020 already transcribed,
# then the held-out sheets F/021-F/033 (covers and backs left out).
DEFAULT = [
    "216/259/Babbage_Papers__Table_Multiplication_1836_Jan_5.ptif",
    "216/261/Babbage_Papers__Bolting_Plates_for_Multiplication_by_Table.ptif",
    "216/263/Babbage_Papers__Table_Division_1836_Jan_8.ptif",
    "216/264/Babbage_Papers__Table_Division_1836_Jan_8.ptif",
    "216/266/Babbage_Papers__Table_Division_1836_Jan_8.ptif",
    "216/267/Babbage_Papers__Table_Division_1836_Jan_8.ptif",
    "216/271/Babbage_Papers__Multiplication_without_Table_1836_Jan_11.ptif",
    "216/273/Babbage_Papers__Multiplication_without_Table_1836_Jan_11.ptif",
    "216/278/Babbage_Papers.ptif",
    "216/280/Babbage_Papers__Division_without_Table_1836_Jan_13.ptif",
    "216/282/Babbage_Papers__Division_without_Table_1836_Jan_13.ptif",
    "216/286/Babbage_Papers__Division_without_Table_1836_Jan_13.ptif",
    "216/288/Babbage_Papers__Division_without_Table_1836_Jan_13.ptif",
    "216/292/Babbage_Papers__Square_Root_1836_Jan_15.ptif",
    "216/293/Babbage_Papers__Square_Root_1836_Jan_15.ptif",
    "216/295/Babbage_Papers__Square_Root_1836_Jan_15.ptif",
    "216/296/Babbage_Papers__Square_Root_1836_Jan_15.ptif",
    "216/298/Babbage_Papers__Square_Root_1836_Jan_15.ptif",
    "216/299/Babbage_Papers__Square_Root_1836_Jan_15.ptif",
    "216/301/Babbage_Papers__Square_Root_1836_Jan_15.ptif",
    "216/302/Babbage_Papers__Square_Root_1836_Jan_15.ptif",
    "216/311/Babbage_Papers__Ordinary_Cycle_of_16_1836_Jan_18.ptif",
    "216/316/Babbage_Papers__Notation_of_Carriage_1836_Jan_25.ptif",
]

_last = [0.0]


def _get(url):
    """One polite request: wait DELAY since the last, back off on refusal."""
    for attempt in range(8):
        wait = DELAY - (time.time() - _last[0])
        if wait > 0:
            time.sleep(wait)
        _last[0] = time.time()
        try:
            req = urllib.request.Request(url, headers={"User-Agent": UA})
            with urllib.request.urlopen(req, timeout=60) as r:
                return r.read()
        except urllib.error.HTTPError as e:
            if e.code in (403, 429) or e.code >= 500:
                time.sleep(min(300, 15 * 2 ** attempt))
                continue
            raise
        except (urllib.error.URLError, TimeoutError):
            time.sleep(min(300, 10 * 2 ** attempt))
    raise RuntimeError(f"gave up on {url}")


def _dir(path):
    a, b = path.split("/")[:2]
    return CACHE / f"{a}-{b}"


def info(path):
    d = _dir(path)
    f = d / "info.json"
    if not f.exists():
        d.mkdir(parents=True, exist_ok=True)
        f.write_bytes(_get(BASE + urllib.parse.quote(path, safe="") + "/info.json"))
    return json.loads(f.read_text())


def tile(path, x, y):
    """The tile whose top left is (x, y), from the cache or fetched once."""
    f = _dir(path) / f"{x}_{y}.jpg"
    if not f.exists():
        meta = info(path)
        w = min(TILE, meta["width"] - x)
        h = min(TILE, meta["height"] - y)
        url = f"{BASE}{urllib.parse.quote(path, safe='')}/{x},{y},{w},{h}/{w},/0/default.jpg"
        data = _get(url)
        tmp = f.with_suffix(".part")
        tmp.write_bytes(data)
        tmp.rename(f)
    return f


def crop(path, x, y, w, h):
    """A region at full resolution, stitched from cached tiles (PIL image)."""
    from PIL import Image
    out = Image.new("RGB", (w, h), "white")
    for ty in range(y // TILE * TILE, y + h, TILE):
        for tx in range(x // TILE * TILE, x + w, TILE):
            t = Image.open(tile(path, tx, ty))
            out.paste(t, (tx - x, ty - y))
    return out


def fill(paths):
    for p in paths:
        meta = info(p)
        W, H = meta["width"], meta["height"]
        coords = [(x, y) for y in range(0, H, TILE) for x in range(0, W, TILE)]
        todo = [c for c in coords if not (_dir(p) / f"{c[0]}_{c[1]}.jpg").exists()]
        print(f"{p}: {W} x {H}, {len(coords)} tiles, {len(todo)} to fetch", flush=True)
        for x, y in todo:
            tile(p, x, y)
        write_manifest()


def write_manifest():
    entries = []
    if CACHE.exists():
        for d in sorted(CACHE.iterdir()):
            f = d / "info.json"
            if not f.exists():
                continue
            meta = json.loads(f.read_text())
            W, H = meta["width"], meta["height"]
            n = len([c for c in d.iterdir() if c.suffix == ".jpg"])
            total = ((W + TILE - 1) // TILE) * ((H + TILE - 1) // TILE)
            entries.append({"image": d.name.replace("-", "/"), "source": meta.get("id"), "width": W,
                             "height": H, "tiles": n, "complete": n == total})
    MANIFEST.write_text(json.dumps({"cache": "sources/downloads/smg/tiles (not committed)",
                                    "server": BASE, "tile": TILE, "images": entries}, indent=2) + "\n")


if __name__ == "__main__":
    cmd = sys.argv[1] if len(sys.argv) > 1 else "status"
    if cmd == "fill":
        fill(sys.argv[2:] or DEFAULT)
    write_manifest()
    for e in json.loads(MANIFEST.read_text())["images"]:
        print(f"{e['image']}: {e['tiles']} tiles, {'complete' if e['complete'] else 'partial'}")
