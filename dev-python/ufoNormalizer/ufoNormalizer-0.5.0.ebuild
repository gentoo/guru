# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

PYTHON_COMPAT=( python3_{7,8,9} pypy3 )
DISTUTILS_USE_SETUPTOOLS=rdepend
MYPN="${PN,,}"
MYP="${MYPN}-${PV}"
inherit distutils-r1

DESCRIPTION="A tool that will normalize the XML and other data inside of a UFO."
HOMEPAGE="https://github.com/unified-font-object/ufoNormalizer"
SRC_URI="mirror://pypi/${MYPN:0:1}/${MYPN}/${MYP}.zip"

SLOT="0"
LICENSE="BSD"
KEYWORDS="~amd64"

DEPEND=""
RDEPEND=""
BDEPEND="app-arch/unzip"

S="${WORKDIR}/${MYP}"

distutils_enable_tests setup.py
