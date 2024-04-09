# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 toolchain-funcs

DESCRIPTION="Tool to communicate with Qualcomm System On a Chip bootroms"
HOMEPAGE="https://github.com/linux-msm/qdl"
EGIT_REPO_URI="https://github.com/andersson/qdl.git"

LICENSE="BSD"
SLOT="0"

BDEPEND="virtual/libudev
		virtual/pkgconfig
		dev-libs/libxml2
"

src_compile() {
	PKG_CONFIG=$(tc-getPKG_CONFIG)
	emake CC=$(tc-getCC) \
		"CFLAGS=${CFLAGS} `${PKG_CONFIG} --cflags libxml-2.0`" \
		"LDFLAGS=${LDFLAGS} `${PKG_CONFIG} --libs libxml-2.0 libudev`"
}

src_install() {
	emake prefix="${EPREFIX}/usr" DESTDIR="${D}" install
	insinto "/usr/share/${PN}"
	doins LICENSE
	dodoc README
}
