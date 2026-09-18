#!/usr/bin/env python3

# Similar to last_status.py, this is just a script to replace the `gh`
# cli behavior with the forgejo/codeberg equivalent. Gets the last
# commit that had a successful run for the given job.

import http.client
import json
import os

host = "codeberg.org"
owner = os.getenv("REPO_OWNER")
name = os.getenv("REPO_NAME")
workflow = os.getenv("REPO_WORKFLOW")
path = (
    f"/api/v1/repos/{owner}/{name}/actions/runs/?workflow_id={workflow}"
    f"&status=success&page=1&limit=1"
)

def main():
    conn = http.client.HTTPSConnection(host)
    conn.request("GET", path)
    response = conn.getresponse()
    if response.status != 200:
        print(f"Didn't get 200 OK! Got {response.status} instead.")
        print(
            "The response body may be helpful: "
            f"{response.read().decode('utf-8')}"
        )
        exit(1)
    j = json.loads(response.read())

    # If run has literally never succeeded before, assume failure
    if j["total_count"] == 0:
        print("none") # this'll cause VALID=false later?
    else:
        # The first workflow run should be the most recent one
        print(j["workflow_runs"][0]["commit_sha"])

main()
