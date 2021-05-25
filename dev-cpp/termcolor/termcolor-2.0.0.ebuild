# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="Header-only library for printing colored messages to the terminal"
HOMEPAGE="https://termcolor.readthedocs.io/"
SRC_URI="https://github.com/ikalnytskyi/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

src_configure() {
	local mycmakeargs=(
		"-DTERMCOLOR_TESTS=$(usex test)"
	)

	cmake_src_configure
}

src_test() {
	"${BUILD_DIR}"/test_termcolor || die
}
