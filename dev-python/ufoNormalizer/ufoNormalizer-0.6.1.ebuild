# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} pypy3 )

inherit distutils-r1 pypi

DESCRIPTION="A tool that will normalize the XML and other data inside of a UFO"
HOMEPAGE="https://github.com/unified-font-object/ufoNormalizer"
SRC_URI="$(pypi_sdist_url ${PN} ${PV} .zip)"

SLOT="0"
LICENSE="BSD"
KEYWORDS="~amd64 ~x86"

BDEPEND="app-arch/unzip"

distutils_enable_tests unittest
