# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit qmake-utils

if [[ "${PV}" == "9999" ]]; then
	inherit git-r3

	EGIT_REPO_URI="https://github.com/molke-productions/${PN}"
fi

DESCRIPTION="Tool to measure loudspeaker frequency and step responses and distortions"
HOMEPAGE="https://github.com/molke-productions/qloud"

if [[ "${PV}" != "9999" ]]; then
	SRC_URI="https://github.com/molke-productions/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
fi

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RESTRICT="test"

BDEPEND="
	dev-qt/linguist-tools:5
"
## x11-libs/qwt:6 to be removed in the near future
RDEPEND="
	dev-qt/qtcharts:5
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtprintsupport:5
	dev-qt/qtwidgets:5
	dev-qt/qtxml:5
	media-libs/libsndfile
	sci-libs/fftw:3.0
	virtual/jack

	x11-libs/qwt:6
"
DEPEND="${RDEPEND}"

src_prepare() {
	default

	sed -e "s!/usr/local!${EPREFIX}/usr!" \
		-i config.pri || die

	sed -e "s!/usr/include/qwt!${EPREFIX}/usr/include/qwt6!" \
		-i src/src.pro || die

	sed -e "s!-lqwt!-lqwt6-qt5!" \
		-i src/src.pro || die
}

src_configure() {
	eqmake5
}

src_install() {
	emake INSTALL_ROOT="${D}" install
}
