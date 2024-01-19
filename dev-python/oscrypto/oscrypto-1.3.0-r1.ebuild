# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} pypy3 )
DISTUTILS_USE_PEP517=setuptools
inherit edo distutils-r1 optfeature

DESCRIPTION="TLS sockets, key generation, encryption, decryption, signing, verification"
HOMEPAGE="
	https://pypi.org/project/oscrypto/
	https://github.com/wbond/oscrypto
"
SRC_URI="https://github.com/wbond/${PN}/archive/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	dev-libs/openssl
	>=dev-python/asn1crypto-1.5.1[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		$(python_gen_cond_dep 'dev-python/cffi[${PYTHON_USEDEP}]' 'python*')
	)
"

DOCS=( docs {changelog,readme}.md )

distutils_enable_tests unittest

python_test() {
	local -x OSCRYPTO_SKIP_INTERNET_TESTS="true"
	edo ${EPYTHON} -m tests
}

pkg_postinst() {
	optfeature "faster FFI" virtual/python-cffi
}
