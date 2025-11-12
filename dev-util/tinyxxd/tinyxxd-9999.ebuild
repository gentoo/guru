# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit edo toolchain-funcs

DESCRIPTION="Drop-in replacement and standalone version of xxd"
HOMEPAGE="https://github.com/xyproto/tinyxxd"
if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/xyproto/tinyxxd.git"
else
	SRC_URI="https://github.com/xyproto/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="|| ( GPL-2 MIT )"

SLOT="0"

IUSE="xxd"

RDEPEND="
	xxd? (
		!<app-editors/vim-core-9.1.1652-r1
		!dev-util/xxd
	)
"

PATCHES=( "${FILESDIR}"/${PN}-1.3.7-fix-flags.patch )

src_compile() {
	export CFLAGS LDFLAGS
	tc-export CC
	emake
}

src_test() {
	edo ./testfiles/test13.sh
	edo ./testfiles/test14.sh
}

src_install(){
	emake DESTDIR="${D}" PREFIX="${EPREFIX}"/usr install
	if use xxd; then
		dosym -r /usr/bin/tinyxxd /usr/bin/xxd
	fi
}
