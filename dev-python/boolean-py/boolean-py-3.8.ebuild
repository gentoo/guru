# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} pypy3 )
inherit distutils-r1

MY_PN=${PN/-/.}
MY_P="${MY_PN}-${PV}"
DESCRIPTION="Define boolean algebras, create boolean expressions and custom boolean DSL"
HOMEPAGE="
	https://pypi.org/project/boolean.py/
	https://github.com/bastikr/boolean.py
"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"

DOCS=( CHANGELOG.rst README.rst )

distutils_enable_tests unittest

distutils_enable_sphinx docs
