# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit nimble

DESCRIPTION="TOML parser library for Nim"
HOMEPAGE="
	https://nimparsers.github.io/parsetoml/
	https://github.com/NimParsers/parsetoml
"
SRC_URI="https://github.com/NimParsers/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="~amd64"

DOCS=( docs/. README.md )

set_package_url "https://github.com/NimParsers/parsetoml"
