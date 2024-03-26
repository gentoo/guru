# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="Tool to communicate with Qualcomm System On a Chip bootroms"
COMMIT_ID="3b22df2bc7de02d867334af3a7aa8606db4f8cdd"
HOMEPAGE="https://github.com/andersson/qdl"
SRC_URI="https://github.com/linux-msm/qdl/archive/${COMMIT_ID}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/${PN}-${COMMIT_ID}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="virtual/libudev
		virtual/pkgconfig
		dev-libs/libxml2
"

PATCHES=(
	"${FILESDIR}/makefile.patch"
	"${FILESDIR}/include_stdlib.patch"
)

src_compile() {
	emake CC=$(tc-getCC) PKG_CONFIG=$(tc-getPKG_CONFIG)
}

src_install() {
	default
	insinto "/usr/share/${PN}"
	doins LICENSE
}
