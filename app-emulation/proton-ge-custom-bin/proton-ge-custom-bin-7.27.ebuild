# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
MULTILIB_COMPAT=( abi_x86_{32,64} )
inherit multilib-minimal

DESCRIPTION="A fancy custom distribution of Valves Proton with various patches"
HOMEPAGE="https://github.com/GloriousEggroll/proton-ge-custom"
SRC_URI="https://github.com/GloriousEggroll/proton-ge-custom/releases/download/GE-Proton${PV/./-}/GE-Proton${PV/./-}.tar.gz"
S="${WORKDIR}/GE-Proton${PV/./-}"
LICENSE="0BSD LGPL-2+ ZLIB MIT MPL-2.0 OFL-1.1 BSD"
SLOT="${PV}"
KEYWORDS="~amd64"
RESTRICT="mirror strip"
QA_PREBUILT={*}

RDEPEND="
		media-libs/mesa[vulkan,${MULTILIB_USEDEP}]
		media-libs/vulkan-loader[${MULTILIB_USEDEP}]"

src_install() {
	insinto "/usr/share/Steam/compatibilitytools.d/"
	doins -r "${S}"
}
