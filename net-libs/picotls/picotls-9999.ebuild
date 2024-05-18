# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="TLS 1.3 implementation in C"
HOMEPAGE="https://github.com/h2o/picotls"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/h2o/picotls"
else
	PTLS_COMMIT="7970614ad049d194fe1691bdf0cc66c6930a3a2f"
	PTLS_TEST_COMMIT="f390562fd4d6919807441721ec05b08f6d8c8d9c"
	SRC_URI="
		https://github.com/h2o/picotls/archive/${PTLS_COMMIT}.tar.gz -> ${P}.tar.gz
		https://github.com/h2o/picotest/archive/${PTLS_TEST_COMMIT}.tar.gz -> ${P}-test.tar.gz
	"
	KEYWORDS="~amd64"
	S="${WORKDIR}/picotls-${PTLS_COMMIT}"
fi

LICENSE="MIT"
SLOT="0"

PTLS_FLAGS_X86_RAW=( avx2 aes pclmul )
PTLS_FLAGS=( "${PTLS_FLAGS_X86_RAW[@]/#/cpu_flags_x86_}" )
IUSE="fusion test ${PTLS_FLAGS[@]}"
REQUIRED_USE="fusion? ( ${PTLS_FLAGS[@]} )"
RESTRICT="!test? ( test )"

DEPEND="
	app-arch/brotli
"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/${PN}-0_pre20220721-disable-e2e.patch" )

src_prepare() {
	if [[ -d "${WORKDIR}/picotest-${PTLS_TEST_COMMIT}" ]] ; then
		rmdir "${S}/deps/picotest" || die
		mv "${WORKDIR}/picotest-${PTLS_TEST_COMMIT}/" "${S}/deps/picotest" || die
	fi
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DWITH_DTRACE=OFF
		-DWITH_FUSION=$(usex fusion ON OFF)
	)
	cmake_src_configure
}

src_test() {
	cmake_build check
}
