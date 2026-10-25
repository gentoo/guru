# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit qmake-utils

DESCRIPTION="Tool to measure loudspeaker frequency and step responses and distortions"
HOMEPAGE="https://github.com/molke-productions/qloud"
if [[ "${PV}" == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/molke-productions/${PN}"
else
	SRC_URI="https://github.com/molke-productions/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-2"
SLOT="0"

RESTRICT="test"

BDEPEND="
	dev-qt/qttools:6[linguist]
"
RDEPEND="
	dev-qt/qtcharts:6
	dev-qt/qtbase:6[gui,widgets,xml]
	media-libs/libsndfile
	sci-libs/fftw:3.0
	virtual/jack
"
DEPEND="${RDEPEND}"

src_configure() {
	eqmake6 PREFIX="${EPREFIX}/usr"
}

src_install() {
	emake \
		INSTALL_ROOT="${D}" \
		install
}
