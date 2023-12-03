# Copyright 2022-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1
PYTHON_COMPAT=( python3_{10..12} pypy3 )
inherit distutils-r1 pypi

DESCRIPTION="Accessible themes for Pygments"
HOMEPAGE="
	https://pypi.org/project/tempus-themes/
	https://gitlab.com/protesilaos/tempus-themes-generator
"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/pygments[${PYTHON_USEDEP}]"
