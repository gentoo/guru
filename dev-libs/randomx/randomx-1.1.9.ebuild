# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake flag-o-matic

DESCRIPTION="Proof of work algorithm based on random code execution"
HOMEPAGE="https://github.com/tevador/RandomX"
SRC_URI="https://github.com/tevador/RandomX/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

S="${WORKDIR}"/RandomX-${PV}

src_configure() {
	append-ldflags -Wl,-z,noexecstack
	cmake_src_configure
}
