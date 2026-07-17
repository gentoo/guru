# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Tang binding daemon"
HOMEPAGE="https://github.com/latchset/tang"
SRC_URI="https://github.com/latchset/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test systemd"
BDEPEND="app-text/asciidoc
	test? (
		net-misc/socat
		net-misc/curl
	)
	"
# Also compatible with net-libs/http-parser, but that project was archived in Nov 2022
# and is considered deprecated
# tangd does not explicity link against jansson, but it does use it. Because dev-libs/jose
# uses jansson too, it just happens to work
DEPEND="dev-libs/jansson
	dev-libs/jose
	net-libs/llhttp
"
RDEPEND="
	${DEPEND}
	acct-user/tang
	!systemd? ( net-misc/socat )
"

RESTRICT="!test? ( test )"

src_configure() {
	local emesonargs=(
		"--localstatedir=/var"
	)
	meson_src_configure
}

src_install() {
	meson_install
	newinitd "${FILESDIR}"/tangd.initd tangd
	doconfd "${FILESDIR}"/tangd

	dodir /var/db/tang
	keepdir /var/db/tang
	fowners tang:tang /var/db/tang
	fperms 770 /var/db/tang
}

pkg_postinst() {
	if use systemd
	then
		elog "app-crypt/tang has switched to using upstream systemd scripts which are socket activated"
		elog "Disable the current unit with \"systemctl disable --now tangd.service\""
		elog
		elog "THe socket-activated unit listens on port 80 by default. To change the listening port,"
		elog "create an override unit using \"systemctl edit tangd.socket\""
	fi
}
