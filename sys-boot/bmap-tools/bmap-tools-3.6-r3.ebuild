# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1

MY_P="bmap-tools-${PV}"

DESCRIPTION="Bmaptool is a tool for creating and copyng files using block maps"
HOMEPAGE="https://github.com/intel/bmap-tools"

SRC_URI="https://github.com/intel/bmap-tools/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RESTRICT="!test? ( test )"

RDEPEND="dev-python/six"

DEPEND="
	${RDEPEND}
	test? (
		dev-python/mock[${PYTHON_USEDEP}]
		dev-python/nose[${PYTHON_USEDEP}]
	)
"

src_prepare() {
	eapply_user
	if use test; then
		rm requirements-test.txt || die "Failed to remove old requirement-test.txt"
		cp "${FILESDIR}"/requirements-test.txt ./ || die "Failed to copy new requirement-test.txt"
		rm tests/{test_bmap_helpers,test_api_base}.py || die "Failed to remove broken tests"
		cp "${FILESDIR}"/{test_bmap_helpers,test_api_base}.py tests/ || die "Failed to copy new tests"
	fi
}

python_install_all() {
	distutils-r1_python_install_all
}

distutils_enable_tests nose
