# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

DESCRIPTION="A lightweight file-manager for C Suite"
HOMEPAGE="https://gitlab.com/cubocore/coreapps/corefm"
SRC_URI="https://gitlab.com/cubocore/coreapps/corefm/-/archive/v${PV}/${PN}-v${PV}.tar.bz2"
S="${WORKDIR}/${PN}-v${PV}"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-qt/qtbase:6[dbus,gui,widgets]
	gui-libs/libcprime
	gui-libs/libcsys
"
RDEPEND="${DEPEND}"
