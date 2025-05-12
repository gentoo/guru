# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

DESCRIPTION="A batch file renamer for C Suite"
HOMEPAGE="https://gitlab.com/cubocore/coreapps/corerenamer"
SRC_URI="https://gitlab.com/cubocore/coreapps/corerenamer/-/archive/v${PV}/${PN}-v${PV}.tar.bz2"
S="${WORKDIR}/${PN}-v${PV}"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-qt/qtbase:6[gui,widgets]
	>=gui-libs/libcprime-5.0.0
"
RDEPEND="${DEPEND}"
