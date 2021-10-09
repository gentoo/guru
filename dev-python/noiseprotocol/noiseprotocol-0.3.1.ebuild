# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8,9} )
inherit distutils-r1

DESCRIPTION="Python implementation of Noise Protocol Framework"
HOMEPAGE="https://github.com/plizonczyk/noiseprotocol"
NOISEPROTOCOL_GIT_REVISION="73375448c55af85df0230841af868b7f31942f0a"
SRC_URI="https://github.com/plizonczyk/${PN}/archive/${NOISEPROTOCOL_GIT_REVISION}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=">=dev-python/cryptography-2.8[${PYTHON_USEDEP}]"
BDEPEND=""

distutils_enable_tests pytest

python_prepare_all() {
	sed -e "/find_packages/s:'examples':'examples', 'examples.\*':" -i setup.py || die

	distutils-r1_python_prepare_all
}

S="${WORKDIR}/${PN}-${NOISEPROTOCOL_GIT_REVISION}"
