# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 meson systemd

DESCRIPTION="A DNS over HTTPS resolver for glibc"
HOMEPAGE="https://github.com/dimkr/nss-tls"
EGIT_REPO_URI="https://github.com/dimkr/nss-tls.git"
EGIT_BRANCH="master"

S="${WORKDIR}/${PN}-9999"

LICENSE="LGPL-2.1"
SLOT="0"
IUSE="systemd"

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

pkg_postinst() {
			ewarn "Do Not put ip address of the server in nss-tls.conf"
			ewarn "use the dns name and add record of dns server in /etc/hosts"
			ewarn "echo "8.8.8.8 dns.google" >> /etc/hosts"

}
