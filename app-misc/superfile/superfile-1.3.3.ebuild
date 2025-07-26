# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="Pretty fancy and modern terminal file manager"
HOMEPAGE="https://superfile.netlify.app/"
if [[ "${PV}" == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/yorukot/superfile.git"
	src_unpack() {
		git-r3_src_unpack
		go-module_live_vendor
	}
else
	KEYWORDS="~amd64"
	SRC_URI="https://github.com/yorukot/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
	SRC_URI+=" https://github.com/ingenarel/guru-depfiles/releases/download/${P}-deps.tar.xz/${P}-deps.tar.xz"
fi

LICENSE="MIT"
SLOT="0"

src_compile() {
	ego build -o bin/spf
}

src_install() {
	dobin bin/spf
}
