# Copyright 2023-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit edo toolchain-funcs

DESCRIPTION="Lean and mean pkg-config replacement"
HOMEPAGE="https://github.com/skeeto/u-config"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/skeeto/u-config.git"
else
	SRC_URI="https://github.com/skeeto/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="Unlicense"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

src_compile() {
	edo $(tc-getCC) ${CFLAGS} -o u-config generic_main.c \
		-D PKG_CONFIG_LIBDIR="\"${EPREFIX}/usr/$(get_libdir)/pkgconfig:${EPREFIX}/usr/share/pkgconfig\"" \
		-D PKG_CONFIG_SYSTEM_INCLUDE_PATH="\"${EPREFIX}/usr/include\"" \
		-D PKG_CONFIG_SYSTEM_LIBRARY_PATH="\"${EPREFIX}/$(get_libdir):${EPREFIX}/usr/$(get_libdir)\"" \
		${LDFLAGS}
	use test && edo $(tc-getCC) ${CFLAGS} -o tests test_main.c ${LDFLAGS}
}

src_install() {
	dobin u-config
	doman u-config.1
}

src_test() {
	edo ./tests
}
