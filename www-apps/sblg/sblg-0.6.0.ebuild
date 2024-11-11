# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="A utility for creating static blogs"
HOMEPAGE="https://kristaps.bsd.lv/sblg/"
SRC_URI="https://kristaps.bsd.lv/sblg/snapshots/${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples"

DEPEND="dev-libs/expat"
RDEPEND="${DEPEND}"

# oconfigure specifically tests for BSD functionality on Linux
QA_CONFIG_IMPL_DECL_SKIP=(
	crypt_newhash
	crypt_checkpass
	warnc
	errc
	getexecname
	getprogname
	memset_s
	pledge
	recallocarray
	strtonum
	TAILQ_FOREACH_SAFE
	timingsafe_bcmp
	timingsafe_memcmp
	unveil
)

src_prepare() {
	default

	sed -ie '/^CFLAGS=/s: -g : :' configure || die
}

src_configure() {
	tc-export CC AR

	./configure \
		PREFIX="${EPREFIX}/usr" \
		MANDIR="${EPREFIX}/usr/share/man" \
		LDFLAGS="${LDFLAGS}" \
		CPPFLAGS="${CPPFLAGS}" \
		LIBDIR="/usr/$(get_libdir)" \
		|| die "./configure failed"
}

src_install() {
	emake DESTDIR="${D}" install

	if ! use examples; then
		rm -rf "${ED}/usr/share/${PN}/examples" || die
	fi
}
