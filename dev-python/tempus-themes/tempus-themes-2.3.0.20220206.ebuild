# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..10} pypy3 )
inherit distutils-r1

DESCRIPTION="Accessible themes for Pygments"
HOMEPAGE="
	https://pypi.org/project/tempus-themes/
	https://gitlab.com/protesilaos/tempus-themes-generator
"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/pygments[${PYTHON_USEDEP}]"
