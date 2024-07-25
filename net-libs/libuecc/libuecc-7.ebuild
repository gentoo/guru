# Copyright 1999-2023 Gentoo Authors
#
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit cmake

DESCRIPTION="a very small Elliptic Curve Cryptography library
compatible with Ed25519."
HOMEPAGE="https://github.com/neocturne/libuecc"
SRC_URI="https://github.com/neocturne/libuecc/releases/download/v${PV}/${P}.tar.xz"
LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~arm64"
IUSE="static-libs"

src_install() {
	cmake_src_install
	if ! use static-libs; then
		find "${ED}" -name "*.a" -delete
	fi
}
