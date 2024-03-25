# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 toolchain-funcs

DESCRIPTION="Tool to communicate with Qualcomm System On a Chip bootroms"
HOMEPAGE="https://github.com/andersson/qdl"
EGIT_REPO_URI="https://github.com/andersson/qdl.git"

LICENSE="BSD"
SLOT="0"

BDEPEND="virtual/libudev
		virtual/pkgconfig
		dev-libs/libxml2
"

PATCHES=(
	"${FILESDIR}/${P}-makefile.patch"
	"${FILESDIR}/include_stdlib-${PV}.patch"
)

src_compile() {
	emake CC=$(tc-getCC) PKG_CONFIG=$(tc-getPKG_CONFIG)
}

src_install() {
	default
	insinto "/usr/share/${PN}"
	doins LICENSE
}
