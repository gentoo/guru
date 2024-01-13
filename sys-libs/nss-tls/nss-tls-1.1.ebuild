# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="A DNS over HTTPS resolver for glibc"
HOMEPAGE="https://github.com/dimkr/nss-tls"
SRC_URI="https://github.com/dimkr/nss-tls/archive/${PV}.tar.gz -> ${P}.tar.gz"

inherit meson systemd

LICENSE="LGPL-2.1"
KEYWORDS="~amd64 ~x86"
IUSE="systemd"
SLOT="0"

RDEPEND="dev-libs/glib
		net-libs/libsoup"
DEPEND="${RDEPEND}
		sys-libs/glibc[nscd(+)]"
BDEPEND="
		${DEPEND}
		app-alternatives/ninja
		dev-build/meson
"

src_prepare() {
			default
			sed -e "s/@0@\/run\/nss-tls/\/var\/run\/nss-tls/" -i "${S}"/meson.build || die
}

src_configure() {
			local emesonargs=(
				--buildtype=release
			)
			meson_src_configure
}

src_compile() {
			meson_src_compile
}

src_install() {
			if use systemd ; then
						systemd_newunit "${S}"/nss-tlsd.service.in nss-tlsd.service
			else
						doinitd "${FILESDIR}"/nss-tlsd
			fi
			meson_src_install
}

post_install() {
			ewarn "Do Not put ip address of the server in nss-tls.conf"
			ewarn "use the dns name and add record of dns server in /etc/hosts"
			ewarn "echo "8.8.8.8 dns.google" >> /etc/hosts"

}
