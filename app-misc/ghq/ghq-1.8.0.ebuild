# Copyright 2019-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="Remote repository management made easy"
HOMEPAGE="https://github.com/x-motemen/ghq"
if [[ "${PV}" == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/x-motemen/ghq.git"
	src_unpack() {
		git-r3_src_unpack
		go-module_live_vendor
	}
else
	SRC_URI="https://github.com/x-motemen/ghq/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	SRC_URI+=" https://github.com/ingenarel/guru-depfiles/releases/download/${P}-deps.tar.xz/${P}-deps.tar.xz"
	KEYWORDS="~amd64"
	#bump the CURRENT_REVISION on the next release
	MY_GIT_REV="406c7dc"
fi

LICENSE="MIT"
SLOT="0"
RESTRICT="mirror"

src_prepare(){
	default
	sed -i -E 's/^\s*build:\s*deps\s*$/build:/; s/-s\s+-w\s+//' Makefile || die "sed failed!"
}

src_compile() {
	if [[ "$PV" == 9999 ]]; then
		emake build
	else
		emake build VERSION="${PV}" CURRENT_REVISION="$MY_GIT_REV"
	fi
}

src_install() {
	dobin "${PN}"
	einstalldocs
}
