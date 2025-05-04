# Copyright 2021-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..13} pypy3_11 )
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

RDEPEND="dev-python/pycryptodome[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"

distutils_enable_tests unittest

python_test() {
	"${EPYTHON}" -m unittest -v tests.simple || die
}
