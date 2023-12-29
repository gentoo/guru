# Copyright 2019-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic multilib multiprocessing toolchain-funcs

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

src_prepare() {
	default

	# ld: multiple definition of `dummy'
	local deselect=( sandbox-{capsicum,darwin,pledge,seccomp-filter}.o )
	case ${CHOST} in
		*-linux-*)
			deselect=( "${deselect[@]/sandbox-seccomp-filter.o}" )
			;;
		*-darwin*)
			deselect=( "${deselect[@]/sandbox-darwin.o}" )
			;;
		*-freebsd*)
			deselect=( "${deselect[@]/sandbox-capsicum.o}" )
			;;
		*-openbsd*)
			deselect=( "${deselect[@]/sandbox-pledge.o}" )
			;;
	esac

	for obj in "${deselect[@]}"; do
		# elements are not deleted completely from the array
		if [[ -n "${obj}" ]]; then
			sed "/${obj}/d" -i Makefile || die
		fi
	done
}

src_configure() {
	tc-export CC AR
	append-cflags -fPIC

	append-cppflags -DENABLE_SECCOMP_FILTER=1
	append-cppflags -DSANDBOX_SECCOMP_DEBUG  # seccomp may cause problems

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
	bmake || die
}

src_test() {
	# TODO: add `afl` tests
	bmake regress || die
}

src_install() {
	bmake DESTDIR="${D}" \
	    DATADIR="${EPREFIX}/usr/share/doc/${PF}/examples" \
	    install || die

	einstalldocs
}
