# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Drop-in replacement and standalone version of xxd"
HOMEPAGE="https://github.com/xyproto/tinyxxd"
if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/xyproto/tinyxxd.git"
else
	SRC_URI="https://github.com/xyproto/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-2"

SLOT="0"

IUSE="xxd"

RDEPEND="xxd? ( !dev-util/xxd !app-editors/vim-core )"

src_install(){
	default
	if use xxd; then
		dosym -r /usr/bin/tinyxxd /usr/bin/xxd
	fi
}
