# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1

MY_COMMIT="e8bdad312fa99c89c74f8651a1240afba8a9f3bd"

DESCRIPTION="Decrypt and encrypt 'Stanford Javascript Crypto Library'-compatible messages"
HOMEPAGE="https://github.com/berlincode/sjcl"

# pypi tarball doesn't contains the tests
SRC_URI="https://github.com/berlincode/sjcl/archive/${MY_COMMIT}.tar.gz -> ${PN}-${MY_COMMIT}.tar.gz"
S="${WORKDIR}/${PN}-${MY_COMMIT}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

distutils_enable_tests setup.py

RDEPEND="
	dev-python/pycryptodome[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"
