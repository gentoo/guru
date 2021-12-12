# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} pypy3 )
DISTUTILS_USE_SETUPTOOLS="pyproject.toml"
inherit distutils-r1 optfeature

DESCRIPTION="Sphinx extension that automatically documents argparse commands and options"
HOMEPAGE="
	https://pypi.org/project/sphinx-argparse/
	https://github.com/ashb/sphinx-argparse
"
SRC_URI="https://github.com/ashb/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/sphinx[${PYTHON_USEDEP}]"

distutils_enable_tests pytest

# requires self to build own documentation
distutils_enable_sphinx docs dev-python/sphinx_rtd_theme dev-python/sphinx-argparse

python_prepare_all() {
	# needs test files in workdir to compile docs for some reason
	cp -r test "${WORKDIR}" || die

	distutils-r1_python_prepare_all
}

python_test() {
	if [[ ${EPYTHON} == python3.10 ]]; then
		EPYTEST_DESELECT=(
			test/test_parser.py::test_parse_nested
			test/test_parser.py::test_parse_nested_with_alias
			test/test_parser.py::test_parse_groups
			test/test_parser.py::test_action_groups_with_subcommands
		)
	fi

	epytest
}

pkg_postinst() {
	optfeature "markdown support" dev-python/commonmark
}
