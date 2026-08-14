# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs edo shell-completion optfeature

DESCRIPTION="Minimal X11 screenshot tool"
HOMEPAGE="https://codeberg.org/NRK/sxot"
SRC_URI="https://codeberg.org/NRK/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/${PN}"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	x11-libs/libX11
	x11-libs/libXfixes
"
DEPEND="${RDEPEND}"

src_compile() {
	edo $(tc-getCC) -o sxot sxot.c ${CFLAGS} ${LDFLAGS} -l X11 -l Xfixes
}

src_install() {
	dobin sxot
	doman sxot.1
	dozshcomp etc/zsh-completion/_sxot
}

pkg_postinst() {
	optfeature "screenshotting off-screen window without a compositor" \
		x11-libs/libXcomposite
}
