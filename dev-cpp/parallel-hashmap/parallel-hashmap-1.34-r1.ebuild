# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Family of header-only, fast and memory-friendly hashmap and btree containers"
HOMEPAGE="
	https://greg7mdp.github.io/parallel-hashmap/
	https://github.com/greg7mdp/parallel-hashmap
"
SRC_URI="https://github.com/greg7mdp/parallel-hashmap/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="examples test"

CDEPEND="dev-libs/cereal"
DEPEND="test? ( ${CDEPEND} )"
RDEPEND="${CDEPEND}"

RESTRICT="!test? ( test )"

src_compile() {
	mycmakeargs=(
		PHMAP_BUILD_EXAMPLES=$(usex examples)
		PHMAP_BUILD_TESTS=$(usex test)
	)

	cmake_src_compile
}

src_install() {
	cmake_src_install
	if use examples ; then
		dodoc -r examples
		docompress -x "/usr/share/doc/${PF}/examples"
	fi
}
