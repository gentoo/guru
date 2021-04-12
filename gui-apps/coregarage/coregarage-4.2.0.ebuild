# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PV="${PV/_/-}"

inherit xdg cmake

DESCRIPTION="A settings manager for C Suite"
HOMEPAGE="https://gitlab.com/cubocore/coreapps/coregarage"

if [[ "${MY_PV}" == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.com/cubocore/coreapps/${PN}.git"
else
	SRC_URI="https://gitlab.com/cubocore/coreapps/${PN}/-/archive/v${MY_PV}/${PN}-v${MY_PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	S="${WORKDIR}/${PN}-v${MY_PV}"
fi

RESTRICT="test"
LICENSE="GPL-3"
SLOT="0"

DEPEND="
	app-arch/libarchive-qt
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	gui-libs/libcprime
	gui-libs/libcsys
"
RDEPEND="
	${DEPEND}
"
