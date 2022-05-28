# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-mod

MY_REV="9a0e137ae05dd1aa05c20750975598e4dac77dbf"

DESCRIPTION="kernel module for random ISN generation"
HOMEPAGE="https://github.com/0xsirus/tirdad"
SRC_URI="https://github.com/0xsirus/tirdad/archive/${MY_REV}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/${PN}-${MY_REV}"

LICENSE="GPL-3"
SLOT="0/${PV}"
KEYWORDS="~amd64"

MODULE_NAMES="tirdad(misc:${S}:${S}/module)"
BUILD_TARGETS="all"

src_compile() {
	linux-mod_src_compile || die
}

src_install() {
	einstalldocs
	linux-mod_src_install || die
}
