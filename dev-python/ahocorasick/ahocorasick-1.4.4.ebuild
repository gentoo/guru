# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..11} )

inherit distutils-r1

MY_PN="py${PN}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Python module implementing Aho-Corasick algorithm"
HOMEPAGE="https://github.com/WojciechMula/pyahocorasick"
SRC_URI="https://github.com/WojciechMula/${MY_PN}/archive/${PV}.tar.gz -> ${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

S="${WORKDIR}/${MY_P}"

distutils_enable_tests pytest
