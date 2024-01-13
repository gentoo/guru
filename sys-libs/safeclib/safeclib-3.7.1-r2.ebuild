# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MODULE_OPTIONAL_USE=modules

inherit autotools linux-info linux-mod

DESCRIPTION="safec libc extension with all C11 Annex K functions"
HOMEPAGE="https://github.com/rurban/safeclib"
SRC_URI="https://github.com/rurban/safeclib/releases/download/v${PV}/${P}.tar.xz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+constraint-handler doc +extensions modules norm-compat +nullslack test unsafe valgrind +wchar"

RESTRICT="!test? ( test )"
BDEPEND="
	doc? ( app-text/doxygen[dot] )
	valgrind? ( dev-util/valgrind )
"

PATCHES=( "${FILESDIR}/${P}-stdarg.patch" )

MODULE_NAMES="slkm(misc:${S}:${S})"
BUILD_TARGETS="all"
BUILD_PARAMS="-f Makefile.kernel V=1"

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

	# duplicate the working folder
	# one for the library and one for the module
	cd "${WORKDIR}" || die
	cp -r "${S}" "${S}-lib" || die
}

src_configure() {
	export VARTEXFONTS="${T}/fonts"

	local myconf=(
		--disable-static
		--disable-valgrind-sgcheck
		--disable-Werror
		--enable-shared
		$(use_enable constraint-handler)
		$(use_enable doc)
		$(use_enable extensions)
		$(use_enable norm-compat)
		$(use_enable nullslack)
		$(use_enable unsafe)
		$(use_enable valgrind)
		$(use_enable wchar)
	)

	if use modules ; then
		set_kvobj ko
		ECONF_PARAMS="${myconf[@]} --disable-wchar"
	fi

	cd "${S}-lib" || die

	econf "${myconf[@]}"
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

	if use doc ; then
		rm -rf doc/man || die
		dodoc -r doc/.
		docompress -x "/usr/share/doc/${PF}/html"

		# wcsstr towupper towlower manpages collide with sys-apps/man-pages
		rm "${ED}/usr/share/man/man3/towlower.3" || die
		rm "${ED}/usr/share/man/man3/towupper.3" || die
		rm "${ED}/usr/share/man/man3/wcsstr.3" || die
	fi

	find "${ED}" -name '*.la' -delete || die
}

src_test() {
	cd "${S}-lib" || die
	emake check
}
