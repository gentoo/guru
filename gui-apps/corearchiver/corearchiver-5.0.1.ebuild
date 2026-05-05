# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

DESCRIPTION="Archiver for C Suite, to create and extract archives"
HOMEPAGE="https://gitlab.com/cubocore/coreapps/corearchiver"
SRC_URI="https://gitlab.com/cubocore/coreapps/corearchiver/-/archive/v${PV}/${PN}-v${PV}.tar.bz2"
S="${WORKDIR}/${PN}-v${PV}"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	app-arch/libarchive-qt[qt6(+)]
	dev-qt/qtbase:6[gui,widgets]
	gui-libs/libcprime
"
RDEPEND="${DEPEND}"
