# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

COMMIT="1af2c0f4cc2aa3c50d906adc8da7a6ceb2ba5df7"
EPYTEST_DESELECT=(
	tests/test_installed_distributions.py::test_installed_distributions_legacy_version
	tests/test_installed_distributions.py::test_installed_distributions_multiple_paths
)
DISTUTILS_SETUPTOOLS="pyproject.toml"
PYTHON_COMPAT=( python3_{8..10} pypy3 )

inherit distutils-r1

DESCRIPTION="An unofficial, importable pip API"
HOMEPAGE="https://github.com/di/pip-api"
SRC_URI="https://github.com/di/pip-api/archive/${COMMIT}.tar.gz -> ${P}-${COMMIT}.tar.gz" # only for 0.0.29
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/pip[${PYTHON_USEDEP}]"
BDEPEND="
	test? (
		dev-python/pretend[${PYTHON_USEDEP}]
		dev-python/toml[${PYTHON_USEDEP}]
		>=dev-python/virtualenv-20[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
