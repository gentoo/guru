# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit qmake-utils

DESCRIPTION="Qt-based GUI for systemd's journalctl command"
HOMEPAGE="https://github.com/pentix/qjournalctl"
SRC_URI="https://github.com/pentix/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
#MY_P="${PN}-v${PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
DOCS=( "CHANGELOG.md" "README.md" )

DEPEND="dev-qt/qtcore
		dev-qt/qtgui
		dev-qt/qtwidgets
		net-libs/libssh"
RDEPEND="${DEPEND}"

src_prepare() {
	default
	eqmake5
}

src_install() {
	emake INSTALL_ROOT="${D}" install
	einstalldocs
}
