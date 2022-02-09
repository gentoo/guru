# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit linux-info linux-mod

DESCRIPTION="Linux kernel driver for reading sensors of AMD Zen family CPUs"
HOMEPAGE="https://github.com/Ta180m/zenpower3"
SRC_URI="https://github.com/Ta180m/zenpower3/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

PATCHES="${FILESDIR}/${P}-use-symlink-to-detect-kernel-version.patch"

CONFIG_CHECK="HWMON PCI AMD_NB"

BUILD_TARGETS="modules"
MODULE_NAMES="zenpower(kernel/drivers/hwmon:${S})"

src_compile() {
	export KV_FULL
	linux-mod_src_compile
}

src_install() {
	linux-mod_src_install
	dobin zp_read_debug.sh
	dodoc README.md
}
