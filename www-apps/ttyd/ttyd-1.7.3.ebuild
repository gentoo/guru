# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake systemd

DESCRIPTION="Share your terminal over the web"
HOMEPAGE="
	https://tsl0922.github.io/ttyd
	https://github.com/tsl0922/ttyd
"
SRC_URI="https://github.com/tsl0922/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-libs/json-c:=
	dev-libs/libuv:=
	dev-libs/openssl:=
	net-libs/libwebsockets:=[libuv,ssl]
	sys-libs/zlib:=
"
RDEPEND="${DEPEND}"

src_install() {
	cmake_src_install

	systemd_dounit "${FILESDIR}"/ttyd.service
	newinitd "${FILESDIR}"/ttyd.initd ttyd
}
