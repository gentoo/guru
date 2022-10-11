# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..11} ) # pypy3 )
# DISTUTILS_USE_PEP517=setuptools
# inherit distutils-r1
inherit distutils-r1

DESCRIPTION="Unicode to ASCII transliteration"
HOMEPAGE="https://github.com/anyascii/anyascii/"
SRC_URI="https://github.com/anyascii/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ISC"
KEYWORDS="~amd64"
SLOT="0"

DEPEND="
	${PYTHON_DEPS}
"

S=${WORKDIR}/${P}/impl/python

distutils_enable_tests pytest
