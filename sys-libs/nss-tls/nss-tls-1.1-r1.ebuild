# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A DNS over HTTPS resolver for glibc"
HOMEPAGE="https://github.com/dimkr/nss-tls"
SRC_URI="https://github.com/dimkr/nss-tls/archive/${PV}.tar.gz -> ${P}.tar.gz"

inherit meson

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="systemd"

RDEPEND="
	dev-libs/glib
	net-libs/libsoup:2.4
"
DEPEND="
	${RDEPEND}
	sys-libs/glibc[nscd(+)]"

src_prepare() {
	default
	sed -e "s/@0@\/run\/nss-tls/\/var\/run\/nss-tls/" -i "${S}"/meson.build || die

	if use systemd; then
		sed -i -e "s/systemd = .*/systemd = dependency('systemd')/" meson.build || die
	else
		sed -i -e "s/systemd = .*/systemd = disabler()/" meson.build || die
	fi
}

src_install() {
	meson_src_install

	doinitd "${FILESDIR}"/nss-tlsd
}

post_install() {
	ewarn "Do Not put ip address of the server in nss-tls.conf"
	ewarn "use the dns name and add record of dns server in /etc/hosts"
	ewarn "echo "8.8.8.8 dns.google" >> /etc/hosts"
}
