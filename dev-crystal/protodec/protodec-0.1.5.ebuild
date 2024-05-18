# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit shards

DESCRIPTION="Command-line tool to encode and decode arbitrary protobuf data"
HOMEPAGE="https://github.com/iv-org/protodec"
SRC_URI="https://github.com/iv-org/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-libs/boehm-gc
	dev-libs/libevent:=
	dev-libs/libpcre
"
RDEPEND="${DEPEND}"

src_prepare() {
	default

	sed -i src/protodec.cr \
		-e 's/\(CURRENT_BRANCH \) = .*/\1 = "master"/' \
		-e 's/\(CURRENT_COMMIT \) = .*/\1 = "gentoo"/' \
		-e "s/\(CURRENT_VERSION\) = .*/\1 = \"v${PV}\"/" || die
}
