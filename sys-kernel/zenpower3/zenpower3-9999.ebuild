# Copyright 2020-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
_PN=zenpower

inherit linux-mod-r1
DESCRIPTION="Linux kernel driver for reading sensors of AMD Zen family CPUs"
HOMEPAGE="
	https://github.com/koweda/zenpower3
	https://github.com/ocerman/zenpower
"

if [[ ${PV} == "9999" ]]; then
	inherit git-r3
	# Mantain fork of zenpower3
	EGIT_REPO_URI="https://github.com/koweda/zenpower3"
else
	SRC_URI="https://github.com/koweda/zenpower3/archive/v0.2.0.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${P}"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-2"
SLOT="0"

CONFIG_CHECK="HWMON PCI AMD_NB"

PATCHES="${FILESDIR}/${PN}-use-symlink-to-detect-kernel-version.patch"

src_compile() {
	MODULES_MAKEARGS+=(
		TARGET="${KV_FULL}"
	)
	local modlist=(
		${_PN}=kernel/drivers/hwmon:::all
	)
	linux-mod-r1_src_compile
}

src_install() {
	linux-mod-r1_src_install
	dodoc README.md
}
