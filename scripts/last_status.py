#!/usr/bin/env python3

# Quick and dirty Python script to replace the behavior of a `gh`
# command that got the last CI/CD status of a given workflow.

import http.client
import json
import os

host = "codeberg.org"
owner = os.getenv("REPO_OWNER")
name = os.getenv("REPO_NAME")
workflow = os.getenv("REPO_WORKFLOW")
path = (
    f"/api/v1/repos/{owner}/{name}/actions/runs/?workflow_id={workflow}"
    "&page=1&limit=1&status=success&status=failure"
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

    # The first workflow run should be the most recent one
    print(j["workflow_runs"][0]["status"])

main()
