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

# echo "# dependency licenses:"; printf 'LICENSES+=" '
# go-licenses report ./... 2>/dev/null | awk -F ',' '{ print $NF }' | sort --unique | tr '\n' ' '; echo '"'

# dependency licenses:
LICENSES+=" Apache-2.0 BSD-2-Clause BSD GPL-3.0 ISC MIT MPL-2.0 "

SLOT="0"
BDEPEND=">=dev-lang/go-1.25.0"

src_compile() {
	CGO_ENABLED=0 ego build -o bin/spf
}

src_install() {
	dobin bin/spf
}
