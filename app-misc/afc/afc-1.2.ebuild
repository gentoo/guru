# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

inherit cmake

DESCRIPTION="Anime File Checker, checks CRC32 contained in filenames"
HOMEPAGE="https://github.com/olifre/afc"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/olifre/${PN}.git"
else
	SRC_URI="https://github.com/olifre/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3+"
SLOT="0"

DEPEND="sys-libs/zlib"
RDEPEND="${DEPEND}"
