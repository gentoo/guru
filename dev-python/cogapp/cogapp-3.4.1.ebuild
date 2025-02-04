# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{{10..13},13t} )

inherit distutils-r1 pypi

DESCRIPTION="Cog content generation tool. Small bits of computation for static files"
HOMEPAGE="
	https://pypi.org/project/cogapp/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

distutils_enable_tests pytest
