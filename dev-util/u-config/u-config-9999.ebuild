# Copyright 2023-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit edo toolchain-funcs

DESCRIPTION="Lean and mean pkg-config replacement"
HOMEPAGE="https://github.com/skeeto/u-config"

PKG_M4_VER="1.9.5"
PKG_M4_URI="symlink? (
	https://github.com/pkgconf/pkgconf/raw/refs/tags/pkgconf-${PKG_M4_VER}/pkg.m4 ->
	${PN}-${PKG_M4_VER}-pkg.m4
)"
if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/skeeto/u-config.git"
	SRC_URI="${PKG_M4_URI}"
else
	SRC_URI="
		https://github.com/skeeto/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
		${PKG_M4_URI}
	"
	KEYWORDS="~amd64 ~x86"
fi

# GPL-2+ coming from pkg.m4
LICENSE="Unlicense symlink? ( GPL-2+ )"
SLOT="0"
IUSE="symlink test"
RESTRICT="!test? ( test )"

RDEPEND="
	symlink? (
		!dev-util/pkgconfig
		!dev-util/pkgconf
	)
"

src_compile() {
	edo $(tc-getCC) ${CFLAGS} -o u-config main_posix.c \
		-D PKG_CONFIG_LIBDIR="\"${EPREFIX}/usr/$(get_libdir)/pkgconfig:${EPREFIX}/usr/share/pkgconfig\"" \
		-D PKG_CONFIG_SYSTEM_INCLUDE_PATH="\"${EPREFIX}/usr/include\"" \
		-D PKG_CONFIG_SYSTEM_LIBRARY_PATH="\"${EPREFIX}/$(get_libdir):${EPREFIX}/usr/$(get_libdir)\"" \
		${LDFLAGS}
	use test && edo $(tc-getCC) ${CFLAGS} -o tests main_test.c ${LDFLAGS}
}

src_install() {
	dobin u-config
	doman u-config.1

	if use symlink; then
		dosym u-config /usr/bin/pkg-config
		dosym u-config /usr/bin/pkgconf
		dosym u-config /usr/bin/"${CHOST}-pkg-config"
		dosym u-config /usr/bin/"${CHOST}-pkgconf"

		insinto /usr/share/aclocal
		newins "${DISTDIR}/${PN}-${PKG_M4_VER}-pkg.m4" pkg.m4
	fi
}

src_test() {
	edo ./tests
}
