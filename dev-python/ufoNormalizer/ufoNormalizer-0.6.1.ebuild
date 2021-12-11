# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="${PN,,}"
MY_P="${MY_PN}-${PV}"
PYTHON_COMPAT=( python3_{8..10} pypy3 )

inherit distutils-r1

DESCRIPTION="A tool that will normalize the XML and other data inside of a UFO"
HOMEPAGE="https://github.com/unified-font-object/ufoNormalizer"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.zip"
S="${WORKDIR}/${MY_P}"

SLOT="0"
LICENSE="BSD"
KEYWORDS="~amd64 ~x86"

BDEPEND="app-arch/unzip"

distutils_enable_tests unittest
