# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit xdg

DESCRIPTION="Visual cross-platform gemini browser"
HOMEPAGE="https://github.com/MasterQ32/kristall"
if [ "${PV}" == "9999" ]; then
	inherit git-r3

	EGIT_REPO_URI="https://github.com/MasterQ32/kristall.git"
else
	SRC_URI="https://github.com/MasterQ32/${PN}/archive/V${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3"
SLOT="0"

RDEPEND="
	dev-qt/qtmultimedia:5[widgets]
	dev-qt/qtsvg:5
	dev-qt/qtnetwork:5[ssl]
"
DEPEND="${RDEPEND}"
BDEPEND="dev-qt/qtcore" # qmake

src_install() {
	emake DESTDIR="${D}" INSTALL="install -D" PREFIX="${EPREFIX}/usr" install
	einstalldocs
}
