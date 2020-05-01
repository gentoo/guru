# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

PYTHON_COMPAT=( python3_{6,7} pypy3 )
DISTUTILS_USE_SETUPTOOLS=rdepend

inherit distutils-r1

DESCRIPTION="A tool that will normalize the XML and other data inside of a UFO."
HOMEPAGE="https://github.com/unified-font-object/ufoNormalizer"
SRC_URI="https://github.com/unified-font-object/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

SLOT="0"
LICENSE="BSD"
KEYWORDS="~amd64"

DEPEND=""
RDEPEND=""
BDEPEND="app-arch/unzip"

distutils_enable_tests setup.py
