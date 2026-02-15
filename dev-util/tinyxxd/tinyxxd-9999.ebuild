# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

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

IUSE="xxd test"
REQUIRED_USE="test? ( !xxd )"
RESTRICT="!test? ( test )"

RDEPEND="
	xxd? (
		!<app-editors/vim-core-9.1.1652-r1
		!dev-util/xxd
	)
	test? ( dev-util/xxd )
"

PATCHES=( "${FILESDIR}/${PN}-1.3.11-fixes.patch" )

src_compile() {
	export CFLAGS LDFLAGS
	tc-export CC
	emake
}

src_install(){
	emake DESTDIR="${D}" PREFIX="${EPREFIX}"/usr install
	if use xxd; then
		dosym -r /usr/bin/tinyxxd /usr/bin/xxd
	fi
}
