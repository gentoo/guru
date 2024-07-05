# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1

DESCRIPTION="Mollie API client for Python"
HOMEPAGE="
	https://www.mollie.com/
	https://github.com/mollie/mollie-api-python/
	https://pypi.org/project/mollie-api-python/
"
SRC_URI="https://github.com/mollie/mollie-api-python/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/requests-oauthlib[${PYTHON_USEDEP}]
	dev-python/urllib3[${PYTHON_USEDEP}]
"

BDEPEND="
	test? (
		dev-python/mock[${PYTHON_USEDEP}]
		dev-python/pytest-mock[${PYTHON_USEDEP}]
		dev-python/responses[${PYTHON_USEDEP}]
	)
"

PATCHES=(
	# https://github.com/mollie/mollie-api-python/pull/347
	"${FILESDIR}/${P}-no-install-tests.patch"
)

distutils_enable_tests pytest

python_prepare_all() {
	distutils-r1_python_prepare_all
	# no pytest-cov
	sed -e '/--cov/d' -e '/--no-cov-on-fail/d' -i pyproject.toml || die
}
