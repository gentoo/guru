# Copyright 2020-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-mod-r1

DESCRIPTION="Linux kernel driver for reading sensors of AMD Zen family CPUs"
HOMEPAGE="https://git.exozy.me/a/zenpower3"
SRC_URI="https://git.exozy.me/a/zenpower3/archive/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

CONFIG_CHECK="HWMON PCI AMD_NB"

PATCHES="${FILESDIR}/${P}-use-symlink-to-detect-kernel-version.patch"

src_compile() {
	export TARGET=${KV_FULL}
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
