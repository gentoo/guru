#!/usr/bin/env python3

import sys
import xml.etree.ElementTree as ET

from http.client import HTTPSConnection
from typing import Iterator, NamedTuple
from urllib.parse import quote_plus


class Maintainer(NamedTuple):
    name: str
    email: str

    def check_details(self, client: HTTPSConnection):
        try:
            client.request("GET", f"/rest/user?names={quote_plus(self.email)}")
            resp = client.getresponse()
            resp.read()
            return resp.status == 200
        except Exception:
            return False


def read_all_maintainers(files: Iterator[str]) -> Iterator[Maintainer]:
    for file in files:
        try:
            tree = ET.parse(file)
            for maintainer in tree.findall('./maintainer'):
                values = {child.tag: child.text for child in maintainer}
                yield Maintainer(name=values.get('name', ''), email=values.get('email', ''))
        except FileNotFoundError:
            print(file, 'not found')


def check_maintainers(maintainers: Iterator[Maintainer]) -> Iterator[Maintainer]:
    try:
        client = HTTPSConnection('bugs.gentoo.org')
        for m in maintainers:
            if m.check_details(client):
                print(f'\033[92m\u2713 {m.name} <{m.email}>\033[0m')
            else:
                print(f'\033[91m\u2717 {m.name} <{m.email}>\033[0m')
                yield m
    finally:
        client.close()


if __name__ == '__main__':
    try:
        files = input().split()
    except EOFError:
        sys.exit(0)

    maintainers = set(read_all_maintainers(files))
    missing_maintainers = tuple(check_maintainers(maintainers))
    sys.exit(int(len(missing_maintainers) != 0))
