# Copyright 2019-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic toolchain-funcs

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
IUSE="debug static-libs test"
RESTRICT="!test? ( test )"

RDEPEND="
	app-crypt/libmd
	dev-libs/libbsd
	virtual/libcrypt
"
DEPEND="${RDEPEND}
	test? (
		net-misc/curl
		sys-libs/zlib
	)
"
BDEPEND="
	dev-build/bmake
	virtual/pkgconfig
	kernel_linux? ( sys-kernel/linux-headers )
	test? ( net-misc/curl )
"

# bug 921122
QA_CONFIG_IMPL_DECL_SKIP=( "*" )

src_prepare() {
	default

	# bug 921120
	sed "/CFLAGS=/s/ -g / /" -i configure || die
}

src_configure() {
	tc-export CC AR
	append-cppflags $(usex debug "-DSANDBOX_SECCOMP_DEBUG" "-DNDEBUG")

	# Recommended by upstream
	append-cflags $(pkg-config --cflags libbsd-overlay)
	append-ldflags $(pkg-config --libs libbsd-overlay)

	# note: not an autoconf configure script
	local conf_args=(
		CPPFLAGS="${CPPFLAGS}"
		LDFLAGS="${LDFLAGS}"
		PREFIX="${EPREFIX}/usr"
		MANDIR="${EPREFIX}/usr/share/man"
		LIBDIR="${EPREFIX}/usr/$(get_libdir)"
		SBINDIR="${EPREFIX}/usr/sbin"
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

	docompress -x /usr/share/doc/${PF}/examples
	einstalldocs

	# bug 921121
	find "${ED}"/usr/$(get_libdir) -name "*.a" -delete || die
}
