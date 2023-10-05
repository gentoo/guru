# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

if [[ ${PV} == *9999 ]] ; then
	EGIT_REPO_URI="https://github.com/eclipse-iceoryx/iceoryx"
	inherit git-r3
else
	SRC_URI="https://github.com/eclipse-iceoryx/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

DESCRIPTION="Eclipse Iceoryx zero copy IPC"
HOMEPAGE="https://iceoryx.io"

LICENSE="Apache-2.0"
SLOT="0/$(ver_cut 1-2)"
IUSE="test doc examples ccache"
RESTRICT="!test? ( test )"

RDEPEND=(
	"doc? ( app-doc/doxygen )"
	"dev-cpp/cpptoml"
	"ccache? ( dev-util/ccache )"
	)

DEPEND="${RDEPEND[@]}"

src_prepare() {
	CMAKE_USE_DIR=${S}/${PN}_meta
	BUILD_DIR="${S}_build"
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_DOC= $(usex doc)
		-DBUILD_ALL=OFF
		-DBINDING_C=ON
		-DEXAMPLES=$(usex examples)
		-DBUILD_TEST=$(usex test)
		-DCLANG_TIDY=OFF
		-DDOWNLOAD_TOML_LIB=OFF
		-DCMAKE_MODULE_PATH="/usr/lib/cmake/cpptoml"
		-DCCACHE=$(usex ccache)
	)

	cmake_src_configure
}
