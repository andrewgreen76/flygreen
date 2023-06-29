#!/usr/bin/env python3

import argparse
import sys

from lib import foreach_repo, github

parser = argparse.ArgumentParser(description="View PRs on all Pop!_OS repositories")
parser.add_argument("repos", nargs="*", default=[])
args = parser.parse_args(sys.argv[1:])

def callback(repo):
    print("\x1B[1m" + repo["name"] + "\x1B[0m")

    prs = github(repo["pulls_url"].replace("{/number}", ""))

    prs.sort(key=lambda pr: pr["number"])

    for pr in prs:
        if pr["state"] == "open":
            print(str(pr["number"]) + ": " + pr["title"] + ": " + pr["html_url"])

foreach_repo(callback, args.repos)