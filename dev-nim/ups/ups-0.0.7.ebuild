# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit edo nimble

DESCRIPTION="a package handler"
HOMEPAGE="https://github.com/disruptek/ups"
SRC_URI="https://github.com/disruptek/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="~amd64"

IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="=dev-nim/npeg-0*"
BDEPEND="
	test? (
		${RDEPEND}
		dev-nim/balls
	)
"

set_package_url "https://github.com/disruptek/ups"

src_test() {
	edo balls
}
