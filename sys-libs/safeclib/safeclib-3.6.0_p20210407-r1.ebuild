# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MODULE_OPTIONAL_USE=modules
inherit autotools linux-info linux-mod

MY_REV="986f6d34e49637d68cb41221307231f0ea79ca4d"

DESCRIPTION="safec libc extension with all C11 Annex K functions"
HOMEPAGE="https://github.com/rurban/safeclib"
SRC_URI="https://github.com/rurban/safeclib/archive/${MY_REV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+constraint-handler doc +extensions modules norm-compat +nullslack test unsafe valgrind"
RESTRICT="!test? ( test )"
PATCHES=( "${FILESDIR}/gh96.patch" )
BDEPEND="
	doc? ( app-doc/doxygen[dot] )
	valgrind? ( dev-util/valgrind )
"

S="${WORKDIR}/${PN}-${MY_REV}"
MODULE_NAMES="slkm(misc:${S}:${S})"
BUILD_TARGETS="all"
BUILD_PARAMS="-f Makefile.kernel"

pkg_setup() {
	if use modules ; then
		CONFIG_CHECK="COMPAT_32BIT_TIME"
		ERROR_COMPAT_32BIT_TIME="module require COMPAT_32BIT_TIME to build"
	fi
	linux-mod_pkg_setup
}

src_prepare() {
	default
	eautoreconf

	#duplicate the working folder
	#one for the library and one for the module
	cd "${WORKDIR}" || die
	cp -r "${S}" "${S}-lib" || die
}

src_configure() {
	if use modules ; then
		set_kvobj ko
		econf "${myconf[@]}" --disable-wchar
	fi

	cd "${S}-lib" || die
	#forcing wchar because of https://github.com/rurban/safeclib/issues/95
	local myconf=(
		--disable-static
		--disable-valgrind-sgcheck
		--enable-shared
		--disable-Werror
		$(use_enable constraint-handler)
		$(use_enable doc)
		$(use_enable extensions)
		$(use_enable norm-compat)
		$(use_enable nullslack)
		$(use_enable unsafe)
		$(use_enable valgrind)
	)
	econf "${myconf[@]}" --enable-wchar
}

src_compile() {
	if use modules ; then
		linux-mod_src_compile
	fi

	cd "${S}-lib" || die
	default
}

src_install() {
	if use modules ; then
		linux-mod_src_install
	fi

	cd "${S}-lib" || die
	default
	einstalldocs
	use doc && dodoc -r doc/.

	# wcsstr towupper towlower manpages collide with sys-apps/man-pages
	rm "${ED}/usr/share/man/man3/towlower.3" || die
	rm "${ED}/usr/share/man/man3/towupper.3" || die
	rm "${ED}/usr/share/man/man3/wcsstr.3" || die
}

src_test() {
	cd "${S}-lib" || die
	emake check
}
