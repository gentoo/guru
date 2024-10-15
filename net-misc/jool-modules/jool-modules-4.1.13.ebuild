# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-mod-r1

DESCRIPTION="Jool is an Open Source SIIT and NAT64 for linux"
HOMEPAGE="https://nicmx.github.io/Jool/en/index.html"
SRC_URI="https://github.com/NICMx/Jool/releases/download/v${PV}/jool-${PV}.tar.gz"
S="${WORKDIR}/jool-${PV}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

src_configure() {
	true
}

src_compile() {
	local modlist=(
		jool_common=:src/mod/common:src/mod/common
		jool=:src/mod/nat64:src/mod/nat64
		jool_siit=:src/mod/siit:src/mod/siit
	)
	local modargs=( KERNEL_DIR="${KV_OUT_DIR}" MODULES_DIR="/lib/modules/${KV_FULL}" )
	linux-mod-r1_src_compile
}

src_install() {
	linux-mod-r1_src_install
}
