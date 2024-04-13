# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1

DESCRIPTION="Hosted coverage reports for GitHub, Bitbucket and Gitlab"
HOMEPAGE="https://github.com/codecov/codecov-python https://pypi.org/project/codecov"
SRC_URI="https://github.com/codecov/codecov-python/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/codecov-python-${PV}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=dev-python/requests-2.7.9[${PYTHON_USEDEP}]
	dev-python/coverage[${PYTHON_USEDEP}]"

python_prepare_all() {
	# The tests does not follow the naming convention
	rm -r "${S}/tests"
	distutils-r1_python_prepare_all
}
# BDEPEND="
# 	test? (
# 		dev-python/pytest[${PYTHON_USEDEP}]
# 		dev-python/ddt[${PYTHON_USEDEP}]
# 		dev-python/mock[${PYTHON_USEDEP}]
# 		dev-python/pytest-cov[${PYTHON_USEDEP}]
# 		dev-python/funcsigs[${PYTHON_USEDEP}]
# 		dev-python/requests[${PYTHON_USEDEP}]
# 		dev-python/black[${PYTHON_USEDEP}]
# 	)"

# distutils_enable_tests pytest
