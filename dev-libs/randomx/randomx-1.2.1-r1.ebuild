# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake flag-o-matic

DESCRIPTION="Proof of work algorithm based on random code execution"
HOMEPAGE="https://github.com/tevador/RandomX"
SRC_URI="https://github.com/tevador/RandomX/archive/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}"/RandomX-${PV}

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

PATCHES=( "${FILESDIR}"/${PN}-1.2.1_remove-fPIE.patch )

src_configure() {
	append-ldflags -Wl,-z,noexecstack
	cmake_src_configure
}
