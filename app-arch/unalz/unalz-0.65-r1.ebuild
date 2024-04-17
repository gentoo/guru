# Copyright 2020-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Extract ALZ archives"
HOMEPAGE="http://kippler.com/win/unalz/"
SRC_URI="
	http://kippler.com/win/${PN}/${P}.tgz
	https://git.launchpad.net/ubuntu/+source/unalz/patch/?id=b4ade05e7e6dec25fee7d57bac6a055137e332c0 -> ${PN}-0.65-use-system-zlib.patch
	https://git.launchpad.net/ubuntu/+source/unalz/patch/?id=00932925e108f186301c5941130fc34c9a76f345 -> ${PN}-0.65-use-system-bz2.patch
"
S="${WORKDIR}"/${PN}

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="
	app-arch/bzip2
	sys-libs/zlib
	virtual/libiconv
"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}"/${P}-buildfix-wrong-data-type.patch
	"${DISTDIR}"/${P}-use-system-zlib.patch
	"${DISTDIR}"/${P}-use-system-bz2.patch
	"${FILESDIR}"/${P}-respect-compiler-flags.patch
)

src_compile() {
	emake linux-utf8
}

src_install() {
	dobin "${S}"/unalz
}
