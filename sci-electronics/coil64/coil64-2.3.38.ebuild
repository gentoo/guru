# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"
MY_PN="${PN/c/C}"

inherit desktop qmake-utils xdg

DESCRIPTION="Coil64 is inductance coil calculator"
HOMEPAGE="
	https://coil32.net
	https://github.com/radioacoustick/Coil64
"

if [[ "${PV}" == "9999" ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/radioacoustick/${MY_PN}.git"
else
	SRC_URI="https://github.com/radioacoustick/${MY_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~arm64 ~riscv ~x86"
	S="${WORKDIR}/${MY_PN}-${PV}"
fi

LICENSE="GPL-3"
SLOT="0"

RDEPEND="
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtprintsupport:5
	dev-qt/qtwidgets:5
"

DEPEND="
	${RDEPEND}
"

src_configure() {
	eqmake5 PREFIX="${EPREFIX}"/usr
}

src_install() {
	default
	dobin "${S}/${MY_PN}"
	dosym "${MY_PN}" "/usr/bin/${PN}"
	doicon -s scalable "${FILESDIR}/${PN}.svg"
	domenu "${FILESDIR}/${PN}.desktop"
}
