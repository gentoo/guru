# Copyright 2021-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="Banish the mouse cursor when typing, show it again when the mouse moves"
HOMEPAGE="https://github.com/jcs/xbanish"

COMMIT="189ce79b1df4eb4995980530ebc3d28715a67488"
SRC_URI="https://github.com/jcs/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

KEYWORDS="~amd64"
LICENSE="ISC"
SLOT="0"

RDEPEND="
	x11-libs/libX11
	x11-libs/libXfixes
	x11-libs/libXi
	x11-libs/libXext
"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

src_compile() {
	emake CC=$(tc-getCC)
}

src_install() {
	dobin xbanish
	doman xbanish.1
}
