# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="Shared C library to include Cisco-like CLI into other software"
HOMEPAGE="https://dparrish.com/pages/libcli"
SRC_URI="https://github.com/dparrish/${PN}/archive/V${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="test static-libs"

# Test disabled for being an interactive test
# RESTRICT="!test? ( test )"
RESTRICT="test"

DEPEND="virtual/libcrypt:="
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}"/libcli-1.10.7-makefile.patch
)

src_configure() {
	tc-export CC AR
	export LIBSUBDIR="$(get_libdir)"
	export PREFIX=/usr
	export STATIC_LIB="$(usex static-libs 1 0)"
	export TESTS="$(usex test 1 0)"
}

src_test() {
	LD_LIBRARY_PATH=. ./clitest
}
