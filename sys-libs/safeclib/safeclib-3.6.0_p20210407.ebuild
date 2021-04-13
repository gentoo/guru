# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools linux-mod

MY_REV="986f6d34e49637d68cb41221307231f0ea79ca4d"

DESCRIPTION="safec libc extension with all C11 Annex K functions"
HOMEPAGE="https://github.com/rurban/safeclib"
SRC_URI="https://github.com/rurban/safeclib/archive/${MY_REV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+constraint-handler +extensions modules norm-compat +nullslack test unsafe valgrind"
RESTRICT="!test? ( test )"
BDEPEND="
	app-doc/doxygen[dot]
	valgrind? ( dev-util/valgrind )
"
S="${WORKDIR}/${PN}-${MY_REV}"

MODULE_NAMES="slkm(misc:${S}-module:${S}-module)"
BUILD_TARGETS="all"
BUILD_PARAMS="-f Makefile.kernel"

src_prepare() {
	eautoreconf
	default

	if use modules ; then
		#duplicate the working folder
		#one for the library and one for the module
		cd "${WORKDIR}" || die
		cp -r "${S}" "${S}-module" || die
	fi
}

src_configure() {
	#forcing wchar because of https://github.com/rurban/safeclib/issues/95
	local myconf=(
		--disable-static
		--disable-valgrind-sgcheck
		--enable-shared
		$(use_enable constraint-handler)
		$(use_enable extensions)
		$(use_enable norm-compat)
		$(use_enable nullslack)
		$(use_enable unsafe)
		$(use_enable valgrind)
	)
	econf "${myconf[@]}" --enable-wchar

	if use modules ; then
		cd "${S}-module" || die
		econf "${myconf[@]}" --disable-wchar
	fi
}

src_compile() {
	default

	if use modules ; then
		cd "${S}-module" || die
		linux-mod_src_compile
	fi
}

src_install() {
	# wcsstr towupper towlower manpages collide with sys-apps/man-pages
	# what to do?
	default
	einstalldocs
	rm -r doc/man || die
	dodoc -r doc/.

	if use modules ; then
		cd "${S}-module" || die
		linux-mod_src_install
	fi
}

src_test() {
	emake check
}
