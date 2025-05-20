# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

DESCRIPTION="A bookmarking app for C Suite"
HOMEPAGE="https://gitlab.com/cubocore/coreapps/corepins"
SRC_URI="https://gitlab.com/cubocore/coreapps/corepins/-/archive/v${PV}/${PN}-v${PV}.tar.bz2"
S="${WORKDIR}/${PN}-v${PV}"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-qt/qtbase:6[gui,widgets]
	>=gui-libs/libcprime-5.0.0
"
RDEPEND="${DEPEND}"
