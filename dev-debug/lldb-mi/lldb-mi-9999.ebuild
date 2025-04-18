# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LLVM_COMPAT=( {15..21} )

inherit cmake llvm-r1

DESCRIPTION="LLDB Machine Interface Driver"
HOMEPAGE="https://github.com/lldb-tools/lldb-mi"

if [[ ${PV} = 9999* ]]; then
	EGIT_REPO_URI="https://github.com/lldb-tools/lldb-mi.git"
	EGIT_BRANCH="main"
	inherit git-r3
else
	SRC_URI="
		https://github.com/lldb-tools/lldb-mi/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz
	"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="Apache-2.0-with-LLVM-exceptions"
SLOT="0"

IUSE="test"

RESTRICT="!test? ( test )"

RDEPEND="
	llvm-core/lldb:=
	$(llvm_gen_dep '
		llvm-core/llvm:${LLVM_SLOT}
	')
"
DEPEND="${RDEPEND}
	test? (
		dev-cpp/gtest
	)
"

PATCHES=(
	"${FILESDIR}/${PN}-0.0.1-find_packages_GTest.patch"
)

src_configure() {
	local mycmakeargs=(
		-DINCLUDE_TESTS="$(usex test)"
	)
	cmake_src_configure
}
