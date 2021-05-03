# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="Family of header-only, fast and memory-friendly hashmap and btree containers"
HOMEPAGE="
	https://greg7mdp.github.io/parallel-hashmap/
	https://github.com/greg7mdp/parallel-hashmap
"
SRC_URI="https://github.com/greg7mdp/parallel-hashmap/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="examples"

DEPEND=""
RDEPEND="${DEPEND}"

#TODO: explore the various cmake options (if any)
#TODO: tests

src_compile() {
	cmake_src_compile
}

src_install() {
	cmake_src_install
	if use examples ; then
		dodoc -r examples
		docompress -x "/usr/share/doc/${PF}/examples"
	fi
}
