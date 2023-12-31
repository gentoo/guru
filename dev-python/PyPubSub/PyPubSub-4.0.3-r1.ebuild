# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Forked from : https://data.gpo.zugaina.org/HomeAssistantRepository/dev-python/PyPubSub/PyPubSub-4.0.3.ebuild

EAPI=8
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )
inherit distutils-r1

DESCRIPTION="Python Publish-Subscribe Package"
HOMEPAGE="https://github.com/schollii/pypubsub https://pypi.org/project/PyPubSub/"
MY_PN="pypubsub"
SRC_URI="https://github.com/schollii/${MY_PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

DOCS="README.rst"

BDEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? (
		dev-python/pytest[${PYTHON_USEDEP}]
	)"

distutils_enable_tests pytest

python_test() {
	cd tests/suite
	distutils-r1_python_test
}
