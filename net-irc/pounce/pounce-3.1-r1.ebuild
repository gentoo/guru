# Copyright 2022-2025 Gentoo Authors
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
RDEPEND="${DEPEND}
	acct-user/pounce
"
BDEPEND="virtual/pkgconfig"

DOCS=( {QUIRKS,README}.7 )

src_configure() {
	tc-export CC

	local confargs=(
		--enable-notify
		$(use_enable palaver)

		--prefix="${EPREFIX}/usr"
		--mandir="${EPREFIX}/usr/share/man"
	)

	# note: not an autoconf configure script
	edo ./configure "${confargs[@]}"
}

src_compile() {
	emake all
}

src_install() {
	emake DESTDIR="${D}" install
	einstalldocs

	newinitd "${FILESDIR}"/pounce.initd-r1 pounce
	newconfd "${FILESDIR}"/pounce.confd-r1 pounce

	insinto /etc/pounce
	doins "${FILESDIR}"/example.conf
}
