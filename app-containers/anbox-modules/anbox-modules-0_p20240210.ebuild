# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-mod-r1

DESCRIPTION="Anbox kernel modules"
HOMEPAGE="https://github.com/choff/anbox-modules"

MY_PV="44e5ba79f515b3cd22d96b4e3ab0f74d5361eb79"
SRC_URI="https://github.com/choff/anbox-modules/archive/${MY_PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${MY_PV}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

src_compile() {
	local modlist=(
		# "updates/" is the directory specified in dkms.conf
		ashmem_linux=updates:ashmem
		binder_linux=updates:binder
	)
	local modargs=( KERNEL_SRC="${KV_OUT_DIR}" )

	linux-mod-r1_src_compile
}
