# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit qmake-utils

DESCRIPTION="simple, sleek QT based DE for wayland using wayfire"

HOMEPAGE="https://gitlab.com/cubocore/paper/paperdesktop"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.com/cubocore/paper/paperdesktop"
else
	COMMIT=960ff1e31a48e96e10afa0459183e52fbea8f2de
	SRC_URI="https://gitlab.com/cubocore/paper/paperdesktop/-/archive/${COMMIT}/paperdesktop-${COMMIT}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}"/paperdesktop-${COMMIT}
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"

DEPEND="
	dev-libs/libdbusmenu-qt
	dev-libs/wayland
	dev-qt/qtcore:5
	dev-qt/qtgui:5[wayland,X]
	dev-qt/qtnetwork:5
	dev-qt/qtwidgets:5[X]
	dev-qt/qtsvg:5
"
RDEPEND="${DEPEND}
	gui-wm/wayfire[X]
	x11-misc/qt5ct
"
BDEPEND="
	virtual/pkgconfig
"

PATCHES=( "${FILESDIR}"/${PN}-0_p20201107-build.patch )

src_prepare() {
	default
	sed -e "s:/lib/:/$(get_libdir)/:" \
		-i libpaperdesktop/core/core.pro \
		-i libpaperdesktop/gui/gui.pro \
		-i libpapershell-wl/libpapershell-wl.pro \
		-i libpaperprime/libpaperprime.pro || die
}

src_compile() {
	eqmake5 paperdesktop.pro
	emake
}

src_install() {
	emake INSTALL_ROOT="${ED}" install
}
