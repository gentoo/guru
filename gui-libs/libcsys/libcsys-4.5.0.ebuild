# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Library for managing the device"
HOMEPAGE="https://gitlab.com/cubocore/libcsys"

if [[ "${PV}" == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.com/cubocore/libcsys.git"
else
	SRC_URI="https://gitlab.com/cubocore/libcsys/-/archive/v${PV}/${PN}-v${PV}.tar.bz2"
	KEYWORDS="~amd64"
	S="${WORKDIR}/${PN}-v${PV}"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE="udisks"

DEPEND="
	dev-qt/qtcore:5
	dev-qt/qtdbus:5
	dev-qt/qtnetwork:5
"
RDEPEND="
	${DEPEND}
	udisks? (
		sys-fs/udisks:2
	)
"
