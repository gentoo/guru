# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Mnemonic seed library for Monero and other CryptoNote-based currencies."
HOMEPAGE="https://github.com/tevador/polyseed"
SRC_URI="https://github.com/tevador/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="" #todo: make test executible an optiona; USE flag
BDEPEND="virtual/pkgconfig"
