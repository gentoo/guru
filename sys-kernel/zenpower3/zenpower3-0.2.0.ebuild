# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-info linux-mod-r1

DESCRIPTION="Linux kernel driver for reading sensors of AMD Zen family CPUs"
HOMEPAGE="https://github.com/Ta180m/zenpower3"
SRC_URI="https://github.com/Ta180m/zenpower3/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

CONFIG_CHECK="HWMON PCI AMD_NB"

src_compile() {
	export KERNELVERSION=${KV_FULL}
	local modlist=(
		zenpower=misc:::all
	)
	linux-mod-r1_src_compile
}

src_install() {
	linux-mod-r1_src_install
	dobin zp_read_debug.sh
	dodoc README.md
}
