# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake flag-o-matic

DESCRIPTION="Proof of work algorithm based on random code execution"
HOMEPAGE="https://github.com/tevador/RandomX"
SRC_URI="https://github.com/tevador/RandomX/archive/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}"/RandomX-${PV}

LICENSE="BSD"
SLOT="0/$(ver_cut 1)"
KEYWORDS="~amd64 ~arm64 ~x86"

PATCHES=( "${FILESDIR}"/${PN}-1.2.1_remove-fPIE.patch )

src_configure() {
	# Should be fixed in >1.2.3
	# https://github.com/tevador/RandomX/pull/341
	append-ldflags -Wl,-z,noexecstack

	cmake_src_configure
}

pkg_postinst() {
	if $(use x86); then
		ewarn "Upstream recommends mining on 64bit processor architectures. You are not"
		ewarn "using one so expect the hashrate to be smaller. For more see the below link:"
		ewarn "https://github.com/tevador/RandomX/#which-cpu-is-best-for-mining-randomx"
	fi
}
