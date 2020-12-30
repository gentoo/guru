# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="QtQuick components providing basic image editing capabilities"
HOMEPAGE="https://invent.kde.org/libraries/kquickimageeditor"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://invent.kde.org/libraries/${PN}.git"
else
	SRC_URI="https://invent.kde.org/libraries/${PN}/-/archive/v${PV}/${PN}-v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="LGPL-2.1+"
SLOT="0"

DEPEND="
	dev-qt/qtcore
"

RDEPEND="${DEPEND}"

S="${WORKDIR}/kquickimageeditor-v0.1.2"
