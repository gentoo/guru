# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit edo toolchain-funcs

DESCRIPTION="Multi-client, TLS-only IRC bouncer"
HOMEPAGE="https://git.causal.agency/pounce/about/"
SRC_URI="https://git.causal.agency/${PN}/snapshot/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="palaver"

DEPEND="
	dev-libs/libretls:=
	virtual/libcrypt:=
	palaver? (
		dev-db/sqlite:3
		net-misc/curl
	)
"
RDEPEND="${DEPEND}"
BDEPEND="
	virtual/pkgconfig
"

DOCS=( {QUIRKS,README}.7 )

src_configure() {
	tc-export CC

	local confargs=(
		--prefix="${EPREFIX}/usr"
		--mandir="${EPREFIX}/usr/share/man"
	)

	# note: not an autoconf configure script
	edo ./configure "${confargs[@]}"

	pushd extra/notify >/dev/null || die
	edo ./configure "${confargs[@]}"
	popd >/dev/null || die

	if use palaver; then
		pushd extra/palaver >/dev/null || die
		edo ./configure "${confargs[@]}"
		popd >/dev/null || die
	fi
}

src_compile() {
	emake all
	emake -C extra/notify
	use palaver && emake -C extra/palaver
}

src_install() {
	emake DESTDIR="${D}" install
	emake -C extra/notify DESTDIR="${D}" install
	use palaver && emake -C extra/palaver DESTDIR="${D}" install
	einstalldocs

	newinitd "${FILESDIR}"/pounce.initd pounce
	newconfd "${FILESDIR}"/pounce.confd pounce

	insinto /etc/pounce
	doins "${FILESDIR}"/example.conf
}
