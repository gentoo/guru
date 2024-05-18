# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 pypi

DESCRIPTION="Checks syntax of reStructuredText and code blocks nested within it"
HOMEPAGE="https://github.com/rstcheck/rstcheck"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/docutils[${PYTHON_USEDEP}]"
BDEPEND="
	>=dev-python/setuptools-scm-1.15.0[${PYTHON_USEDEP}]
	test? (
		${RDEPEND}
		dev-python/path[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

python_test() {
	# Ignore the module from ${S}, use the one from ${BUILD_DIR}
	# Otherwise, ImportMismatchError may occur
	# https://github.com/gentoo/gentoo/pull/1622#issuecomment-224482396
	# Override pytest options to skip flake8
	pytest -vv --ignore=rst --override-ini="addopts=--doctest-modules" \
		|| die "tests failed with ${EPYTHON}"
}
