# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..9} )
inherit distutils-r1

DESCRIPTION="Python 3 Bindings for the NVIDIA Management Library"
HOMEPAGE="
		https://pypi.org/project/py3nvml
		https://github.com/fbcotter/py3nvml
"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

KEYWORDS="~amd64"
LICENSE="BSD"
SLOT="0"
