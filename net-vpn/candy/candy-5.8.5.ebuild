# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake systemd

DESCRIPTION="A reliable, low-latency, and anti-censorship virtual private network"
HOMEPAGE="https://github.com/lanthora/candy"
SRC_URI="https://github.com/lanthora/candy/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-libs/uriparser
	dev-libs/libconfig
	dev-libs/poco
	dev-libs/openssl
	dev-libs/spdlog
"
RDEPEND="${DEPEND}"

src_install(){
	cmake_src_install
	default

	insinto /etc
	doins candy.cfg
	fperms 0644 /etc/candy.cfg

	systemd_dounit candy.service
	systemd_dounit candy@.service
}
