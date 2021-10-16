# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Supporting library for Bats test helpers"
HOMEPAGE="https://github.com/bats-core/bats-support"
SRC_URI="https://github.com/bats-core/bats-support/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="CC0-1.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

RDEPEND="dev-util/bats"
DEPEND="${RDEPEND}"

DOCS=( README.md CHANGELOG.md )
RESTRICT="!test? ( test )"

src_install() {
	insinto "/usr/share/${PN}"
	doins *.bash
	doins -r src
	einstalldocs
}

src_test() {
	bats test || die
}
