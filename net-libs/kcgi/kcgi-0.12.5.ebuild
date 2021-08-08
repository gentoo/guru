# Copyright 2019-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit multiprocessing toolchain-funcs

DESCRIPTION="Minimal CGI library for web applications"
HOMEPAGE="https://kristaps.bsd.lv/kcgi/"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/kristapsdz/${PN}"
else
	SRC_URI="https://kristaps.bsd.lv/${PN}/snapshots/${P}.tgz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="ISC"
SLOT="0"
IUSE="static-libs test"
RESTRICT="!test? ( test )"

BDEPEND="sys-devel/bmake"
RDEPEND="
	app-crypt/libmd
	virtual/libcrypt
"
DEPEND="${RDEPEND}
	test? ( net-misc/curl[static-libs(-)] )
"

PATCHES=( "${FILESDIR}"/${PN}-$(ver_cut 1-2)-ldflags.patch )

src_prepare() {
	default

	# disable failing tests
	sed -e '/\s*regress\/test-debug-.*/d' -i Makefile || die
}

src_configure() {
	tc-export CC AR

	# note: not an autoconf configure script
	conf_args=(
		CPPFLAGS="${CPPFLAGS}"
		LDFLAGS="${LDFLAGS}"
		PREFIX="${EPREFIX}"/usr
		MANDIR="${EPREFIX}"/usr/share/man
		LIBDIR="${EPREFIX}"/usr/$(get_libdir)
		SBINDIR="${EPREFIX}"/usr/sbin
	)
	./configure "${conf_args[@]}" || die
}

src_compile() {
	bmake -j$(makeopts_jobs) || die
}

src_test() {
	# TODO: add `afl` tests
	bmake -j$(makeopts_jobs) regress || die
}

src_install() {
	bmake -j$(makeopts_jobs) \
		DESTDIR="${D}" \
		DATADIR="/usr/share/doc/${PF}/examples" \
		install || die

	# kcgi does not install shared libraries
	if ! use static-libs; then
		find "${ED}" -name '*.a' -delete || die
		find "${ED}" -name '*.pc' -delete || die
	fi

	einstalldocs
}
