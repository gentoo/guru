# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit qmake-utils

DESCRIPTION="A Qt-based library that provides bindings to oFono"
HOMEPAGE="https://github.com/Kaffeine/libofono-qt"
SRC_URI="https://github.com/Kaffeine/libofono-qt/archive/refs/tags/1.30.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

DEPEND="
	dev-qt/qtcore
	dev-texlive/texlive-fontutils
"
RDEPEND="${DEPEND}"
BDEPEND="app-doc/doxygen"

PATCHES=( "${FILESDIR}"/fix_lib64_path.patch )

S="${WORKDIR}/${PN}-qt-${PV}"

src_prepare() {
	default
	sed -i -e 's|/share/doc/ofono-qt|/share/doc/libofono-1.30|' ofono-qt.pro || die
}

src_configure() {
	eqmake5
}

src_install() {
	INSTALL_ROOT="${D}" emake install
}
