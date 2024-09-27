# Copyright 2019-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit shards

DESCRIPTION="Gay sharks at your local terminal"
HOMEPAGE="https://github.com/GeopJr/BLAHAJ"
SRC_URI="https://github.com/GeopJr/BLAHAJ/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${P^^}"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"

src_install() {
	shards_src_install
	dobin ${PN}
}
