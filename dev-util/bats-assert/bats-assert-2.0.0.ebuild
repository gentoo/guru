# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Common assertions for Bats"
HOMEPAGE="https://github.com/bats-core/bats-assert"
SRC_URI="https://github.com/bats-core/bats-assert/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="CC0-1.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

RDEPEND="
	dev-util/bats
	dev-util/bats-support
"
DEPEND="${RDEPEND}"

DOCS=( README.md )
RESTRICT="!test? ( test )"

src_install() {
	insinto "/usr/share/${PN}"
	doins *.bash
	doins -r src
	einstalldocs
}

src_test() {
	ln -s "/usr/share/bats-support" "${WORKDIR}/bats-support" || die
	source /usr/share/bats-support/load.bash || die
	bats test || die
}
