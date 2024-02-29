# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake systemd

DESCRIPTION="Another virtual private network that supports peer-to-peer connections"
HOMEPAGE="https://github.com/lanthora/candy"
SRC_URI="https://github.com/lanthora/candy/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-libs/uriparser
	dev-libs/libconfig
	net-libs/ixwebsocket[ws]
	dev-libs/openssl
	sys-libs/zlib
	dev-libs/libfmt
	dev-libs/spdlog
"
RDEPEND="${DEPEND}"

src_prepare() {
	eapply "${FILESDIR}/${P}-show-version-and-use-cflags-env.patch"
	cmake_src_prepare
	default
}

src_install(){
	cmake_src_install
	default

	insinto /etc
	doins candy.conf
	fperms 0644 /etc/candy.conf

	systemd_dounit candy.service
	systemd_dounit candy@.service
}
