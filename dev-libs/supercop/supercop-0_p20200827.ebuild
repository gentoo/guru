# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake flag-o-matic

MY_REV="633500ad8c8759995049ccd022107d1fa8a1bbc9"

DESCRIPTION="Fast cryptographic operations for Monero wallets"
HOMEPAGE="https://github.com/monero-project/supercop"
SRC_URI="https://github.com/monero-project/supercop/archive/${MY_REV}.tar.gz -> ${PN}-${MY_REV}.tar.gz"

S="${WORKDIR}"/${PN}-${MY_REV}

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"

DEPEND="dev-lang/nasm"

src_configure() {
	append-flags -fPIC
	append-ldflags -Wl,-z,noexecstack
	cmake_src_configure
}
