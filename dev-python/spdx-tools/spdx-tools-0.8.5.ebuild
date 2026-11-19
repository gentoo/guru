# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{13..14} ) # no python3_15 because of beartype

inherit distutils-r1 pypi

DESCRIPTION="A Python library to parse, validate and create SPDX documents"
HOMEPAGE="
	https://github.com/spdx/tools-python
	https://pypi.org/project/spdx-tools/
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

# uritools is required for tests
# this package is not in  ::guru
# due to  it's	heavy  llm	use.
RESTRICT="test"

RDEPEND="
	dev-python/beartype[${PYTHON_USEDEP}]
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/license-expression[${PYTHON_USEDEP}]
	dev-python/ply[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/rdflib[${PYTHON_USEDEP}]
	dev-python/semantic-version[${PYTHON_USEDEP}]
	dev-python/xmltodict[${PYTHON_USEDEP}]
"
