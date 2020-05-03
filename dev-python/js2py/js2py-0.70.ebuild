# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PN="Js2Py"
MY_P="${MY_PN}-${PV}"

PYTHON_COMPAT=( python3_{6,7} )

inherit distutils-r1

DESCRIPTION="JavaScript to Python Translator & JavaScript interpreter written in Python"
HOMEPAGE="
	https://github.com/PiotrDabkowski/Js2Py
	https://pypi.org/project/Js2Py/
"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/pyjsparser-2.5.1[${PYTHON_USEDEP}]
	>=dev-python/tzlocal-1.2.0[${PYTHON_USEDEP}]
	>=dev-python/six-1.10.0[${PYTHON_USEDEP}]
"

S="${WORKDIR}/${MY_P}"
