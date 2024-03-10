# Copyright 2012-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1

DESCRIPTION="Read JUnit/XUnit XML files and map them to Python objects"
HOMEPAGE="https://gitlab.com/woob/xunitparser/"
SRC_URI="https://gitlab.com/woob/xunitparser/-/archive/v${PV}/xunitparser-v${PV}.tar.gz"
S="${WORKDIR}/xunitparser-v${PV}/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

distutils_enable_tests unittest

DOCS=( README LICENSE AUTHORS )
