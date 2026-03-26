# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 optfeature

DESCRIPTION="Intuitive, easy CLIs based on type hints"
HOMEPAGE="
	https://github.com/BrianPugh/cyclopts
	https://pypi.org/project/cyclopts/
"
SRC_URI="https://github.com/BrianPugh/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

RDEPEND="
	>=dev-python/attrs-23.1.0[${PYTHON_USEDEP}]
	>=dev-python/docstring-parser-0.15[${PYTHON_USEDEP}]
	>=dev-python/rich-13.6.0[${PYTHON_USEDEP}]
	>=dev-python/rich-rst-1.3.1[${PYTHON_USEDEP}]
"
BDEPEND="
	dev-python/hatch-vcs[${PYTHON_USEDEP}]
	test? (
		>=dev-python/pydantic-2.11.2[${PYTHON_USEDEP}]
		>=dev-python/pyyaml-6.0.1[${PYTHON_USEDEP}]
		dev-python/sphinx[${PYTHON_USEDEP}]
		>=dev-python/tomli-2.0.0[${PYTHON_USEDEP}]
		>=dev-python/trio-0.10.0[${PYTHON_USEDEP}]
	)
"

EPYTEST_PLUGINS=(
	pytest-mock
	syrupy
)
distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# Requires dev-python/mkdocs
	tests/test_docs_snapshots.py::TestMkDocsDirectiveSnapshots
)
EPYTEST_IGNORE=(
	# Requires dev-python/mkdocs
	tests/test_mkdocs_ext.py
)

export SETUPTOOLS_SCM_PRETEND_VERSION=${PV}

pkg_postinst() {
	optfeature "Trio async backend" dev-python/trio
	optfeature "reading TOML configurations" dev-python/tomli
	optfeature "reading YAML configurations" dev-python/pyyaml
}
