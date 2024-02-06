# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Common assertions for Bats"
HOMEPAGE="https://github.com/bats-core/bats-assert"
SRC_URI="https://github.com/bats-core/bats-assert/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="CC0-1.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	dev-util/bats
	dev-util/bats-support
"
BDEPEND="test? ( ${RDEPEND} )"

DOCS=( README.md )

src_install() {
	insinto "/usr/share/${PN}"
	doins load.bash
	doins -r src
	einstalldocs
}

src_test() {
	BATS_LIB_PATH=/usr/share bats test || die
}
