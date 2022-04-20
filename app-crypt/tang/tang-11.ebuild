# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson systemd

DESCRIPTION="Tang binding daemon"
HOMEPAGE="https://github.com/latchset/tang"
SRC_URI="https://github.com/latchset/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="acct-user/tang
	net-misc/socat
	>=net-libs/http-parser-2.8.0
	>=dev-libs/jose-8"
RDEPEND="${DEPEND}"
BDEPEND="app-text/asciidoc"

src_install(){
	meson_install
	newinitd "${FILESDIR}"/tangd.initd tangd
	systemd_dounit ${FILESDIR}/tangd.service

	dodir /var/db/tang
	keepdir /var/db/tang
	fowners tang:tang /var/db/tang
	fperms 770 /var/db/tang
}

pkg_postinst(){
	einfo "By default, tang runs on port 8888 and listens on address 0.0.0.0"
	einfo "It also stores JWKs in /var/db/tang."
	einfo "If you want to change this, modify /etc/init.d/tangd or"
	einfo "/usr/lib/systemd/system/tangd.service directly."

	systemctl daemon-reload || die
}
