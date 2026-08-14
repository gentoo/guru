# Copyright 2024-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="When you need a web server in a hurry"
HOMEPAGE="https://unix4lyfe.org/darkhttpd/"
SRC_URI="https://github.com/emikulic/darkhttpd/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

# tests fail
RESTRICT="test"

src_install() {
	dodoc README.md
	dobin "${PN}"
}
