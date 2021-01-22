# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

QTMIN="5.15.1"

inherit multilib qmake-utils xdg

DESCRIPTION="Library for managing settings of CoreApps"
HOMEPAGE="https://gitlab.com/cubocore/libcprime"

if [[ "${PV}" == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.com/cubocore/${PN}.git"
else
	SRC_URI="https://gitlab.com/cubocore/${PN}/-/archive/v${PV}/${PN}-v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	S="${WORKDIR}/${PN}-v${PV}"
fi

RESTRICT="test"
LICENSE="GPL-3"
SLOT="0"
IUSE=""

DEPEND="
	x11-libs/libnotify
	>=dev-qt/qtbluetooth-${QTMIN}:5
	>=dev-qt/qtcore-${QTMIN}:5
	>=dev-qt/qtdbus-${QTMIN}:5
	>=dev-qt/qtgui-${QTMIN}:5
	>=dev-qt/qtnetwork-${QTMIN}:5
	>=dev-qt/qtwidgets-${QTMIN}:5
"
RDEPEND="
	${DEPEND}
"

PATCHES=(
	"${FILESDIR}/${PN}-lib.patch"
)

src_configure() {
	local lib="$(get_libdir)"
	# '^^' because we need to upcase the definition
	eqmake5 DEFINES+="${lib^^}"
}

src_install() {
	einstalldocs
	emake INSTALL_ROOT="${D}" install
}
