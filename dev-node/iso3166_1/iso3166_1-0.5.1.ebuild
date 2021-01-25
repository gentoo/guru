# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

MYPN="${PN/_/-}"
SRC_URI="https://registry.npmjs.org/${MYPN}/-/${MYPN}-${PV}.tgz -> ${P}.tgz"
DESCRIPTION="Tiny, fast, modular ISO 3166-1 alpha-2/alpha-3 parser."
HOMEPAGE="
	https://github.com/moimikey/iso3166-1
	https://www.npmjs.com/package/iso3166-1
"
LICENSE="MIT"
KEYWORDS="~amd64"