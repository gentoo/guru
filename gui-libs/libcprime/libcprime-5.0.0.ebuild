# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Library for managing settings of CoreApps"
HOMEPAGE="https://gitlab.com/cubocore/libcprime"
SRC_URI="https://gitlab.com/cubocore/libcprime/-/archive/v${PV}/${PN}-v${PV}.tar.bz2"
S="${WORKDIR}/${PN}-v${PV}"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="dev-qt/qtbase:6[dbus,gui,network,widgets]"
RDEPEND="${DEPEND}"
