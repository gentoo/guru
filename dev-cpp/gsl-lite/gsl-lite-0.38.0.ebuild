# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="C++ Guideline Support Library implementation"
HOMEPAGE="https://github.com/gsl-lite/gsl-lite"
SRC_URI="https://github.com/gsl-lite/gsl-lite/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

# header only library

src_configure() {
	local mycmakeargs=(
		-DGSL_LITE_OPT_BUILD_TESTS=$(usex test)
	)
	cmake_src_configure

	sed -i -e 's/"-*Werror"//g' test/MakeTestTarget.cmake || die
}
