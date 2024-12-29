# Copyright 2020-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-mod-r1
_PN="zenstats"
_P="${_PN}-${PV}"
DESCRIPTION="Linux kernel driver for reading sensors of AMD Zen family CPUs"
HOMEPAGE="
	https://github.com/Sid127/zenstats
	https://github.com/ocerman/zenpower
"

if [[ ${PV} == "9999" ]]; then
	inherit git-r3
	# Mantain fork of zenpower3
	EGIT_REPO_URI="https://github.com/Sid127/zenstats"
else
	SRC_URI="https://github.com/Sid127/zenstats/archive/v0.1.0.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/zenstats-0.1.0"
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
