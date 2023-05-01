# Copyright 2022-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} )
DISTUTILS_USE_PEP517=poetry
inherit distutils-r1 pypi

DESCRIPTION="A tool for compliance with the REUSE recommendations"
HOMEPAGE="
	https://reuse.software/
	https://pypi.org/project/reuse/
	https://github.com/fsfe/reuse-tool
"

LICENSE="Apache-2.0 CC0-1.0 CC-BY-SA-4.0 GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/boolean-py[${PYTHON_USEDEP}]
	dev-python/binaryornot[${PYTHON_USEDEP}]
	dev-python/jinja[${PYTHON_USEDEP}]
	dev-python/license-expression[${PYTHON_USEDEP}]
	dev-python/python-debian[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
"
BDEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	sys-devel/gettext
	test? (
		dev-vcs/git
		dev-vcs/mercurial
	)
"

DOCS=( AUTHORS.rst CHANGELOG.md README.md )

distutils_enable_tests pytest

# [Errno 2] No such file or directory: '../README.md'
#distutils_enable_sphinx docs \
	#dev-python/recommonmark \
	#dev-python/sphinx-autodoc-typehints \
	#dev-python/sphinx-rtd-theme \
	#dev-python/sphinxcontrib-apidoc
