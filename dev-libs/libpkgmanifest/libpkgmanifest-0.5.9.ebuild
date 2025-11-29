# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )
inherit cmake python-r1

DESCRIPTION="Library for working with RPM manifests"
HOMEPAGE="https://github.com/rpm-software-management/libpkgmanifest"
SRC_URI="https://github.com/rpm-software-management/libpkgmanifest/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="~amd64"
IUSE="python test"
REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"
RESTRICT="!test? ( test )"

RDEPEND="
	dev-cpp/yaml-cpp:=
	python? ( ${PYTHON_DEPS} )
"
DEPEND="${RDEPEND}"
BDEPEND="
	virtual/pkgconfig
	python? ( dev-lang/swig )
	test? ( dev-cpp/gtest )
"

src_configure() {
	local mycmakeargs=(
		-DWITH_TESTS=$(usex test)
		-DWITH_DOCS=NO
		-DWITH_PYTHON=$(usex python)
	)
	if use python; then
		python_foreach_impl cmake_src_configure
	else
		cmake_src_configure
	fi
}

src_compile() {
	if use python; then
		python_foreach_impl cmake_src_compile
	else
		cmake_src_compile
	fi
}

src_test() {
	if use python; then
		python_foreach_impl cmake_src_test
	else
		cmake_src_test
	fi
}

src_install() {
	if use python; then
		python_foreach_impl cmake_src_install
		python_foreach_impl python_optimize
	else
		cmake_src_install
	fi
}
