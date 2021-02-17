# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="Font viewer with character table"
HOMEPAGE="http://qfontviewer.sourceforge.net/"
EGIT_REPO_URI="https://github.com/alopatindev/qfontviewer"
LICENSE="GPL-3+"
SLOT="0"

DEPEND="dev-qt/qtwidgets:5"
RDEPEND="${DEPEND}"

src_install() {
	einstalldocs
	newbin "${P}" "${PN}"
}
