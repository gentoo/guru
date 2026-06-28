# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_SINGLE_IMPL=1
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1

DESCRIPTION="Command Line Interface to work with an Open Build Service"

HOMEPAGE="
	https://openbuildservice.org/
	https://github.com/openSUSE/osc
"

SRC_URI="
	https://github.com/openSUSE/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz
"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	app-arch/rpm[python,${PYTHON_SINGLE_USEDEP}]
	$(python_gen_cond_dep '
		dev-python/cryptography[${PYTHON_USEDEP}]
		dev-python/ruamel-yaml[${PYTHON_USEDEP}]
		dev-python/urllib3[${PYTHON_USEDEP}]
	')
"
BDEPEND="
	test? (
		dev-vcs/git
		dev-util/diffstat
	)
"

EPYTEST_DESELECT=(
	# test broken inside venv
	tests/test_doc_plugins.py::TestPopProjectPackageFromArgs::test_plugin_locations
)
distutils_enable_tests pytest
