# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit linux-mod
COMMIT="9a0e137ae05dd1aa05c20750975598e4dac77dbf"
DESCRIPTION="kernel module for random ISN generation"
HOMEPAGE="https://github.com/0xsirus/tirdad"
SRC_URI="https://github.com/0xsirus/tirdad/archive/${COMMIT}.zip -> ${P}.zip"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND="app-arch/unzip"
S="${WORKDIR}/${PN}-${COMMIT}"

MODULE_NAMES="tirdad(misc:${S}:${S}/module)"
BUILD_TARGETS="all"

src_compile() {
	linux-mod_src_compile || die
}

src_install() {
	einstalldocs
	linux-mod_src_install || die
}
