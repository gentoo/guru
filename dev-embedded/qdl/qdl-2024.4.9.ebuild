# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="Tool to communicate with Qualcomm System On a Chip bootroms"
COMMIT_ID="a629f43428ebd17080f55543f893d45694234f75"
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
)

src_compile() {
	emake CC=$(tc-getCC) PKG_CONFIG=$(tc-getPKG_CONFIG)
}

src_install() {
	default
	insinto "/usr/share/${PN}"
	doins LICENSE
}
