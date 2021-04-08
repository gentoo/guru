# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PV="${PV/_/-}"

QTMIN="5.15.1"

inherit cmake

DESCRIPTION="Library for managing the device"
HOMEPAGE="https://gitlab.com/cubocore/libcsys"

if [[ "${PV}" == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.com/cubocore/${PN}.git"
else
	SRC_URI="https://gitlab.com/cubocore/${PN}/-/archive/v${MY_PV}/${PN}-v${MY_PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	S="${WORKDIR}/${PN}-v${MY_PV}"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE="udisks"

DEPEND="
	>=dev-qt/qtcore-${QTMIN}:5
	>=dev-qt/qtdbus-${QTMIN}:5
	>=dev-qt/qtnetwork-${QTMIN}:5
"
RDEPEND="
	${DEPEND}
	udisks? (
		sys-fs/udisks:2
	)
"
