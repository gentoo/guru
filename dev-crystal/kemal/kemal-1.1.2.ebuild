# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit shards

DESCRIPTION="Lightning Fast, Super Simple web framework"
HOMEPAGE="
	https://kemalcr.com/
	https://github.com/kemalcr/kemal
"
SRC_URI="https://github.com/kemalcr/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test"

RDEPEND="
	dev-crystal/exception_page
	dev-crystal/radix
"
