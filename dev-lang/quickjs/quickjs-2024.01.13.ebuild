# Copyright 2021-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

MY_P="${PN}-${PV//./-}"

DESCRIPTION="Small embeddable Javascript engine"
HOMEPAGE="https://bellard.org/quickjs/"
SRC_URI="https://bellard.org/quickjs/${MY_P}.tar.xz"
S="${WORKDIR}/${MY_P}"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="lto"

PATCHES=(
	"${FILESDIR}/quickjs-2020.11.08_Remove-TTY-check-in-test.patch"
	"${FILESDIR}/quickjs-2024-01-13-sharedlib.patch"
	"${FILESDIR}/quickjs-2024-01-13-respect-env.patch"
)

src_prepare() {
	# Changed in master
	sed -i '/^CONFIG_LTO=/s;^;#;' Makefile || die

	default

	sed -i '/$(STRIP) .*/d' Makefile || die "Failed removing STRIP call"

	sed -Ei '/^\s*(CC|AR)=/d' Makefile \
		|| die "Failed to remove hard-coded tools."

	sed -i 's;$(PREFIX)/lib;$(LIBDIR);' Makefile || die "Failed fixing libdir"
}

src_configure() {
	export CC="$(tc-getCC)"
	export AR="$(tc-getAR)"

	export PREFIX=/usr
	export LIBDIR="/usr/$(get_libdir)"

	export CONFIG_LTO=$(use lto)
	export CONFIG_SHARED=y
}
