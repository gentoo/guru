# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CMAKE_IN_SOURCE_BUILD="ON"

inherit cmake

DESCRIPTION="The Lean Theorem Prover"
HOMEPAGE="https://leanprover-community.github.io/"

if [[ "${PV}" == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/leanprover-community/lean.git"
else
	SRC_URI="https://github.com/leanprover-community/lean/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi
S="${WORKDIR}/lean-${PV}/src"

RESTRICT="!test? ( test )"
LICENSE="Apache-2.0"
SLOT="0"
IUSE="+json test +threads"

RDEPEND="dev-libs/gmp"
DEPEND="${RDEPEND}"

src_configure() {
	local mycmakeargs=(
		-DALPHA=ON
		-DAUTO_THREAD_FINALIZATION=ON
		-DJSON=$(usex json)
		-DLEAN_EXTRA_CXX_FLAGS="${CXXFLAGS}"
		-DMULTI_THREAD=$(usex threads)
		-DUSE_GITHASH=OFF
	)
	cmake_src_configure
}

pkg_postinst() {
	elog "You probably want to use lean with mathlib, to install it use leanpkg."
	elog "For example: leanpkg install https://github.com/leanprover-community/mathlib"
}
