# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

FORTRAN_STANDARD="2003"

inherit cmake fortran-2

DESCRIPTION="Jonquil: Bringing TOML blooms to JSON land"
HOMEPAGE="https://toml-f.readthedocs.io/en/latest/how-to/jonquil.html"
SRC_URI="https://github.com/toml-f/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0 MIT"
SLOT="0/2"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RESTRICT="!test? ( test )"

RDEPEND="
	dev-libs/toml-f:0/4
"

DEPEND="
	${RDEPEND}
	test? ( dev-util/fortran-test-drive )
"

src_configure() {
	local mycmakeargs=(
		-DENABLE_TESTING=$(usex test)
	)

	cmake_src_configure
}
