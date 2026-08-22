# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v3

EAPI=8

inherit toolchain-funcs

DESCRIPTION="Shell utilities: sfetch, scat, sls"
HOMEPAGE="https://github.com/hubbydenny/S-ecosystem"
SRC_URI="https://github.com/hubbydenny/S-ecosystem/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND="${DEPEND}"

src_compile() {
	emake CXX="$(tc-getCXX)" CXXFLAGS="${CXXFLAGS}" LDFLAGS="${LDFLAGS}"
}

src_install() {
	dobin sfetch scat sls
	einstalldocs
}

