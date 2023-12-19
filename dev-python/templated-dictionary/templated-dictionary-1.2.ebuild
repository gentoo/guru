# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1
PYTHON_COMPAT=( python3_{11..12} )

inherit distutils-r1 pypi

DESCRIPTION="Python dictionary with Jinja2 expansion"
HOMEPAGE="
	https://github.com/xsuchy/templated-dictionary/
	https://pypi.org/project/templated-dictionary/
"

SLOT="0"
LICENSE="GPL-2+"
KEYWORDS="~amd64"

RDEPEND="dev-python/jinja[${PYTHON_USEDEP}]"
