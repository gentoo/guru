# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MYPV="$(ver_rs 3 -)"
PYTHON_COMPAT=( python3_{8..11} )

inherit distutils-r1

DESCRIPTION="Unicodedata backport for python 2/3 updated to the latest unicode version"
HOMEPAGE="https://github.com/mikekap/unicodedata2"
SRC_URI="https://github.com/mikekap/unicodedata2/archive/refs/tags/${MYPV}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/${PN}-${MYPV}"
KEYWORDS="~amd64"
LICENSE="Apache-2.0"
SLOT="0"

distutils_enable_tests pytest
