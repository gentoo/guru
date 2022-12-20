# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake git-r3

DESCRIPTION="Mnemonic seed library for Monero and other CryptoNote-based currencies."
HOMEPAGE="https://github.com/tevador/polyseed"
SRC_URI=""
EGIT_REPO_URI="https://github.com/tevador/polyseed.git"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS=""
IUSE="" #todo: make test executible an optional USE flag
BDEPEND="virtual/pkgconfig"
