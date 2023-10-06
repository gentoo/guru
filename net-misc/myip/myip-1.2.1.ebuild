# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="Get your external IP address using STUN server"
HOMEPAGE="https://github.com/Snawoot/myip"
EGO_PN="github.com/Snawoot/${PN}"
SRC_URI="https://${EGO_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
SRC_URI+=" https://gentoo.kropotkin.rocks/go-pkgs/${P}-vendor.tar.xz"

LICENSE="MIT BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

src_install() {
	dobin bin/*
}
