#!/usr/bin/env python3
"""Fetch Science Museum Group catalogue records for Babbage papers.

    scripts/fetch-catalogue.py BAB/L/001 BAB/L/002 ... > sources/downloads/smg/seriesL.json

Each record is found by searching for its object number; the record's
multimedia list gives the zoom path of each image (see sources/README.md).
The site refuses requests without a browser-like user agent.
"""
import json
import sys
import time
import urllib.parse
import urllib.request

UA = "Mozilla/5.0 (compatible; research transcription)"


def search(q):
    url = "https://collection.sciencemuseumgroup.org.uk/search/documents?" + urllib.parse.urlencode({"q": q})
    req = urllib.request.Request(url, headers={"User-Agent": UA, "Accept": "application/json"})
    return json.load(urllib.request.urlopen(req))


out = {}
for on in sys.argv[1:]:
    for x in search(on)["data"]:
        ids = [i["value"] for i in x["attributes"].get("identifier", []) if i.get("type") == "object number"]
        if ids and (ids[0] == on or ids[0].startswith(on + "/")):
            out[ids[0]] = x
    time.sleep(1)
json.dump(out, sys.stdout, ensure_ascii=False, indent=1)
