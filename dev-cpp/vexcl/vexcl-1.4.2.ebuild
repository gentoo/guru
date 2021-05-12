# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="VexCL - Vector expression template library for OpenCL"
HOMEPAGE="https://github.com/ddemidov/vexcl"
SRC_URI="https://github.com/ddemidov/vexcl/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
#TODO: cuda doc test
IUSE="examples"

RDEPEND="
	dev-libs/boost:=
	virtual/opencl
"
DEPEND="${RDEPEND}"

src_install() {
	cmake_src_install
	if use examples; then
		dodoc -r examples
		docompress -x "/usr/share/doc/${P}/examples"
	fi
}
