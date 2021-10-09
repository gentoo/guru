# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} pypy3 )

inherit distutils-r1

DESCRIPTION="GPX file parser and GPS track manipulation library"
HOMEPAGE="
	https://github.com/tkrajina/gpxpy
	https://pypi.org/project/gpxpy
"
SRC_URI="https://github.com/tkrajina/gpxpy/archive/v${PV}.tar.gz  -> ${P}.tar.gz"

KEYWORDS="~amd64"
LICENSE="Apache-2.0"
SLOT="0"

distutils_enable_tests unittest
