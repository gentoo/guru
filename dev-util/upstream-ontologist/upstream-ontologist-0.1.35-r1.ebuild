# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )
DISTUTILS_USE_PEP517=setuptools
DISTUTILS_SINGLE_IMPL=1
PYPI_NO_NORMALIZE=1
inherit edo distutils-r1 optfeature pypi

DESCRIPTION="Tracking of upstream project metadata"
HOMEPAGE="
	https://pypi.org/project/upstream-ontologist/
	https://github.com/jelmer/upstream-ontologist
"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	$(python_gen_cond_dep '
		dev-python/python-debian[${PYTHON_USEDEP}]
		dev-python/ruamel-yaml[${PYTHON_USEDEP}]
	')
	dev-vcs/breezy[${PYTHON_SINGLE_USEDEP}]
"
BDEPEND="
	test? (
		$(python_gen_cond_dep '
			dev-python/beautifulsoup4[${PYTHON_USEDEP}]
			dev-python/docutils[${PYTHON_USEDEP}]
			dev-python/lxml[${PYTHON_USEDEP}]
			dev-python/markdown[${PYTHON_USEDEP}]
			dev-python/pygments[${PYTHON_USEDEP}]
			dev-python/tomlkit[${PYTHON_USEDEP}]
		')
	)
"

distutils_enable_tests unittest

python_test() {
	edo ${EPYTHON} -m unittest_or_fail tests.test_debian -v
	edo ${EPYTHON} -m unittest_or_fail tests.test_guess -v
	edo ${EPYTHON} -m unittest_or_fail tests.test_upstream_ontologist -v
	edo ${EPYTHON} -m unittest_or_fail tests.test_vcs -v

	edo ${EPYTHON} -m unittest_or_fail tests.test_readme.test_suite -v
	#edo ${EPYTHON} -m unittest_or_fail tests.testdata.test_suite -v
}

src_install() {
	distutils-r1_src_install

	doman man/*
	dodoc docs/*
}

pkg_postinst() {
	optfeature "homepage parsing support" dev-python/beautifulsoup4
	optfeature "toml support" dev-python/tomlkit
}
