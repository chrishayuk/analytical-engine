#!/usr/bin/env python3
"""Fetch regions of a Science Museum Group image, as the transcriber read it.

    scripts/fetch-region.py ZOOM_PATH OUTDIR COLS ROWS [MAXDIM] [OVERLAP]
    REGION=x,y,w,h scripts/fetch-region.py 222/594/Solution_of_two_simultaneous_equations.ptif out 4 2

The region (default: the whole image) is cut into COLS x ROWS pieces, each
fetched at full size (the IIIF service refuses other sizes) and reduced
locally to MAXDIM pixels (default 1250) with macOS `sips`, if present.
"""
import json
import os
import shutil
import subprocess
import sys
import time
import urllib.parse
import urllib.request

UA = "Mozilla/5.0 (compatible; research transcription)"
path, out, cols, rows = sys.argv[1], sys.argv[2], int(sys.argv[3]), int(sys.argv[4])
maxdim = int(sys.argv[5]) if len(sys.argv) > 5 else 1250
overlap = int(sys.argv[6]) if len(sys.argv) > 6 else 80
base = "https://zoom.sciencemuseumgroup.org.uk/iiif/3/" + urllib.parse.quote(path, safe="")


def get(url):
    return urllib.request.urlopen(urllib.request.Request(url, headers={"User-Agent": UA})).read()


info = json.loads(get(base + "/info.json"))
W, H = info["width"], info["height"]
X, Y, RW, RH = map(int, os.environ.get("REGION", f"0,0,{W},{H}").split(","))
os.makedirs(out, exist_ok=True)
for j in range(rows):
    for i in range(cols):
        x0 = max(X, X + i * RW // cols - overlap)
        y0 = max(Y, Y + j * RH // rows - overlap)
        x1 = min(X + RW, X + (i + 1) * RW // cols + overlap)
        y1 = min(Y + RH, Y + (j + 1) * RH // rows + overlap)
        fn = f"{out}/r{j}c{i}.jpg"
        with open(fn, "wb") as f:
            f.write(get(f"{base}/{x0},{y0},{x1 - x0},{y1 - y0}/max/0/default.jpg"))
        if shutil.which("sips"):
            subprocess.run(["sips", "-Z", str(maxdim), fn], capture_output=True)
        print(fn, x0, y0, x1 - x0, y1 - y0)
        time.sleep(0.5)
