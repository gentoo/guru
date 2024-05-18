# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit xdg cmake

DESCRIPTION="A PDF viewer for C Suite"
HOMEPAGE="https://gitlab.com/cubocore/coreapps/corepdf"

if [[ "${PV}" == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.com/cubocore/coreapps/corepdf.git"
else
	SRC_URI="https://gitlab.com/cubocore/coreapps/corepdf/-/archive/v${PV}/${PN}-v${PV}.tar.bz2"
	KEYWORDS="~amd64"
	S="${WORKDIR}/${PN}-v${PV}"
fi

LICENSE="GPL-3"
SLOT="0"

DEPEND="
	app-text/poppler[qt5]
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtprintsupport:5
	dev-qt/qtwidgets:5
	gui-libs/libcprime
"
RDEPEND="${DEPEND}"
