# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PV="${PV/_/-}"

QTMIN="5.15.1"

inherit cmake

DESCRIPTION="Library for managing settings of CoreApps"
HOMEPAGE="https://gitlab.com/cubocore/libcprime"

if [[ "${PV}" == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.com/cubocore/libcprime.git"
else
	SRC_URI="https://gitlab.com/cubocore/libcprime/-/archive/v${MY_PV}/${PN}-v${MY_PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	S="${WORKDIR}/${PN}-v${MY_PV}"
fi

LICENSE="GPL-3"
SLOT="0"

QTMIN="5.15.1"

DEPEND="
	x11-libs/libnotify
	>=dev-qt/qtcore-${QTMIN}:5
	>=dev-qt/qtdbus-${QTMIN}:5
	>=dev-qt/qtgui-${QTMIN}:5
	>=dev-qt/qtnetwork-${QTMIN}:5
	>=dev-qt/qtwidgets-${QTMIN}:5
"
RDEPEND="
	${DEPEND}
"
