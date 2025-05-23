# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="C library that may be linked into a C/C++ program to produce symbolic backtraces"
HOMEPAGE="https://github.com/ianlancetaylor/libbacktrace"
COMMITHASH="793921876c981ce49759114d7bb89bb89b2d3a2d"
SRC_URI="${HOMEPAGE}/archive/${COMMITHASH}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMITHASH}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="static-libs test"
RESTRICT="!test? ( test )"

BDEPEND="
	test? (
		app-arch/xz-utils
		sys-libs/zlib
	)
"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	econf --enable-shared \
		$(use_enable static{-libs,})
}

src_install() {
	default
	find "${D}" -name '*.la' -delete || die
}
