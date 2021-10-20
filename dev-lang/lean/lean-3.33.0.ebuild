# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CMAKE_IN_SOURCE_BUILD="ON"

inherit cmake optfeature

DESCRIPTION="The Lean Theorem Prover"
HOMEPAGE="https://leanprover-community.github.io/"

if [[ "${PV}" == *9999* ]]; then
	MAJOR=3  # sync this periodically for the live version
	inherit git-r3
	EGIT_REPO_URI="https://github.com/leanprover-community/lean.git"
else
	MAJOR=$(ver_cut 1)
	SRC_URI="https://github.com/leanprover-community/lean/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi
S="${WORKDIR}/lean-${PV}/src"

RESTRICT="!test? ( test )"
LICENSE="Apache-2.0"
SLOT="0/${MAJOR}"
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
	elog "You probably want to use lean with mathlib, to install it you can either:"
	elog " - Do not install mathlib globally and use local versions"
	elog " - Use leanproject from sci-mathematics/mathlib-tools"
	elog "   $ leanproject global-install"
	elog " - Use leanpkg and compile mathlib (which will take long time)"
	elog "   $ leanpkg install https://github.com/leanprover-community/mathlib"

	optfeature "project management with leanproject" sci-mathematics/mathlib-tools
}
