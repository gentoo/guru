# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools flag-o-matic git-r3

MY_PV="$(ver_rs 2 '-')"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="iwd without dbus"
HOMEPAGE="https://github.com/dylanaraps/eiwd"
EGIT_REPO_URI="https://github.com/dylanaraps/eiwd.git"
EGIT_COMMIT="7b5545a"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS=""
IUSE="+client +monitor ofono +resolvconf +system-ell wired"

DEPEND="system-ell? ( >=dev-libs/ell-0.31 )"
RDEPEND="${DEPEND}
	resolvconf? ( || ( net-dns/openresolv net-misc/dhcpcd ) )
	!net-wireless/iwd
	net-wireless/wireless-regdb"
BDEPEND="virtual/pkgconfig"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	append-cflags "-fsigned-char"
	local myeconfargs=(
		--sysconfdir="${EPREFIX}"/etc/iwd --localstatedir="${EPREFIX}"/var
		--disable-dbus
		$(use_enable client)
		$(use_enable monitor)
		$(use_enable ofono)
		$(use_enable system-ell external-ell)
		$(use_enable wired)
	)
	econf "${myeconfargs[@]}"
}

src_install() {
	default
	keepdir /var/lib/iwd
	newinitd "${FILESDIR}"/iwd.initd iwd
	if use resolvconf ; then
		insinto /etc/iwd/
		doins "${FILESDIR}"/main.conf
	fi
}
