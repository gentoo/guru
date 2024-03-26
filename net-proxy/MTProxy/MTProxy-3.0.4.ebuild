# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Community fork of MTProxy"
HOMEPAGE="https://github.com/GetPageSpeed/MTProxy"
SRC_URI="https://github.com/GetPageSpeed/MTProxy/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-libs/openssl
	sys-libs/zlib
"

RDEPEND="${DEPEND}"

src_install() {
	dobin objs/bin/mtproto-proxy
}
