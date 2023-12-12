# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11,12} )

inherit distutils-r1 pypi

DESCRIPTION="Backport of the importlib.resources module"
HOMEPAGE="
	https://pypi.org/project/importlib-resources/
	https://github.com/python/importlib_resources
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="
	test? (
		dev-python/zipp
	)
"

distutils_enable_tests pytest
