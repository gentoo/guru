# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1

DESCRIPTION="Bmaptool is a tool for creating and copyng files using block maps"
HOMEPAGE="https://github.com/intel/bmap-tools"

SRC_URI="https://github.com/intel/bmap-tools/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RESTRICT="test" # missing python slot fot backports-* packages

S="${WORKDIR}/${MY_P}"

RDEPEND="dev-python/six"

# leave it here until backports-* are ported into python3.9 and 10

#DEPEND="
#	${RDEPEND}
#	test? (
#		dev-python/backports-tempfile[${PYTHON_USEDEP}]
#		dev-python/mock[${PYTHON_USEDEP}]
#		dev-python/nose[${PYTHON_USEDEP}]
#	)
#"

python_install_all() {
	distutils-r1_python_install_all
}

#distutils_enable_tests nose
