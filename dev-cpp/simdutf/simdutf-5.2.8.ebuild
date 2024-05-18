# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )

inherit cmake python-any-r1

DESCRIPTION="simdutf: Unicode validation and transcoding at billions of characters per second"
HOMEPAGE="https://simdutf.github.io/simdutf/"
SRC_URI="https://github.com/simdutf/simdutf/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="|| ( Apache-2.0 MIT )"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

BDEPEND="${PYTHON_DEPS}"

RESTRICT="!test? ( test )"

src_configure() {
	local mycmakeargs=( -DSIMDUTF_TESTS=$(usex test ON OFF) )
	cmake_src_configure
}
