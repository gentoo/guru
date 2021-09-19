# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

if [[ ${PV} != *9999* ]]; then
	SRC_URI="https://github.com/tenacityteam/portsmf/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
else
	inherit git-r3
	EGIT_REPO_URI="https://github.com/tenacityteam/portsmf.git"
fi

DESCRIPTION="C++ library for Standard Midi Files (SMF)"
HOMEPAGE="https://github.com/tenacityteam/portsmf"
LICENSE="MIT"
SLOT="0"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""
