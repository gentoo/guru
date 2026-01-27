# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="Pretty fancy and modern terminal file manager"
HOMEPAGE="https://superfile.dev"
if [[ "${PV}" == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/yorukot/superfile.git"
else
	KEYWORDS="~amd64"
	SRC_URI="https://github.com/yorukot/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
	SRC_URI+=" https://github.com/ingenarel/guru-depfiles/releases/download/${P}-deps.tar.xz/${P}-deps.tar.xz"
fi

LICENSE="MIT"
#gentoo-go-license superfile-1.4.0.ebuild
LICENSE+=" Apache-2.0 BSD-2 BSD GPL-3 ISC MIT MPL-2.0 "

SLOT="0"

src_unpack() {
	if [[ "${PV}" == 9999* ]];then
		git-r3_src_unpack
		go-module_live_vendor
	else
		default
	fi
}

src_compile() {
	ego build -o bin/spf
}

src_install() {
	dobin bin/spf
}
