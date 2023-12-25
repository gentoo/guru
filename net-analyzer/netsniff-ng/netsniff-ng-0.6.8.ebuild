# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="high performance network sniffer for packet inspection"
HOMEPAGE="http://netsniff-ng.org/"
if [[ "${PV}" == *9999 ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/borkmann/${PN}.git"
else
	SRC_URI="http://pub.${PN}.org/${PN}/${P}.tar.xz"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE="debug geoip zlib"

RDEPEND="
	dev-libs/libcli:=
	dev-libs/libnl:3
	dev-libs/userspace-rcu:=
	net-libs/libnet:1.1
	net-libs/libnetfilter_conntrack
	net-libs/libpcap
	sys-libs/ncurses:0=
	geoip? ( dev-libs/geoip )
	zlib? ( sys-libs/zlib:= )
"
DEPEND="${RDEPEND}"
BDEPEND="
	sys-devel/flex
	sys-devel/bison
	dev-libs/libsodium
	virtual/pkgconfig
"

src_prepare() {
	default

	sed -e '/CFLAGS/s:?=:+=:' \
		-e '/CPPFLAGS/s:?=:+=:' \
		-e '/CFLAGS/s:\(-g\|-O2\|-O3\|-m\(arch\|tune\)=native\)::g' \
		-i Makefile || die

	if ! grep -Fq nacl-20110221 curvetun/nacl_build.sh ; then
		die "have nacl-20110221, expected $(grep ${MY_NACL_P} curvetun/nacl_build.sh)"
	fi

	export NACL_INC_DIR="${EPREFIX}/usr/include/nacl"
	export NACL_LIB_DIR="${EPREFIX}/usr/$(get_libdir)/nacl"

	# do not compress man pages by default
	sed \
		-e '/gzip/s@\$(Q).*$@$(Q)cp $(1).8 $(1)/$(1).8@' \
		-e 's@\.8\.gz@.8@' \
		-i Template || die

	# fix build ordering in parallel make
	sed -e 's/^trafgen_post_install:$/trafgen_post_install: trafgen_do_install/' \
		-i trafgen/Makefile || die
}

src_configure() {
	local myconfargs=(
		--prefix="${EPREFIX}/usr"
		--sysconfdir="${EPREFIX}/etc"
		$(usex debug --enable-debug '')
		$(usex geoip '' --disable-geoip)
		$(usex zlib '' --disable-zlib)
	)
	# not an autoconf generated configure
	./configure "${myconfargs[@]}" || die
}

src_compile() {
	emake CC="$(tc-getCC)" LD="$(tc-getCC)" CCACHE="" \
		LEX=lex YAAC=bison STRIP=true \
		Q= HARDENING=1
}

src_install() {
	emake PREFIX="${ED}/usr" ETCDIR="${ED}/etc" install

	dodoc AUTHORS README REPORTING-BUGS
}
