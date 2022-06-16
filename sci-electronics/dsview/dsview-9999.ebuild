# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

GITHUB_PN="DSView"
MY_PV="$(ver_rs 2 '')" # 'a.b.c' -> 'a.bc'
PYTHON_COMPAT=( python3_{8..11} )

inherit cmake python-r1 udev xdg

DESCRIPTION="An open source multi-function instrument"
HOMEPAGE="
	https://www.dreamsourcelab.com
	https://github.com/DreamSourceLab/DSView
"

if [[ ${PV} == "9999" ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/DreamSourceLab/${GITHUB_PN}.git"
else
	SRC_URI="https://github.com/DreamSourceLab/${GITHUB_PN}/archive/v${MY_PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}/${GITHUB_PN}-${MY_PV}"
fi

LICENSE="GPL-3"
SLOT="0"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="${PYTHON_DEPS}
	dev-cpp/glibmm:2
	dev-libs/boost
	dev-libs/glib
	dev-libs/libzip
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	dev-qt/qtsvg:5
	dev-qt/qtconcurrent:5
	sci-libs/fftw:3.0
	virtual/libusb:1
"

DEPEND="
	${RDEPEND}
"

BDEPEND="
	virtual/pkgconfig
"

src_configure() {
	local mycmakeargs=(
		-DCMAKE_INSTALL_PREFIX="${EPREFIX}/usr"
	)

	cmake_src_configure
}

pkg_postinst() {
	udev_reload
	xdg_pkg_postinst
}

pkg_postrm() {
	udev_reload
	xdg_pkg_postrm
}
