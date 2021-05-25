# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )
DOCS_DIR="docs"
DOCS_BUILDER="sphinx"

inherit distutils-r1 docs optfeature

DESCRIPTION="Asynchronous SSHv2 client and server library"
HOMEPAGE="
	https://asyncssh.timeheart.net
	https://pypi.org/project/asyncssh
	https://github.com/ronf/asyncssh
"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="ECL-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=">=dev-python/cryptography-2.8[${PYTHON_USEDEP}]"
BDEPEND="
	${REDEPEND}
	test? (
		>=dev-python/bcrypt-3.1.3[${PYTHON_USEDEP}]
		>=dev-python/gssapi-1.2.0[${PYTHON_USEDEP}]
		>=dev-python/libnacl-1.4.2[${PYTHON_USEDEP}]
		>=dev-python/pyopenssl-17.0.0[${PYTHON_USEDEP}]
		>=dev-python/python-pkcs11-0.7.0[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

distutils_enable_sphinx docs

python_test() {
	epytest \
		--deselect tests/test_agent.py::_TestAgent::test_confirm \
		--deselect tests/test_x509.py::_TestX509::test_expired_root
}

pkg_postinst() {
	optfeature "support for OpenSSH private key encryption" dev-python/bcrypt
	optfeature "support for key exchange and authentication with U2F/FIDO2 security keys" dev-python/fido2
	optfeature "support for accessing PIV keys on PKCS#11 security tokens" dev-python/python-pkcs11
	optfeature "support for GSSAPI key exchange and authentication on UNIX" dev-python/gssapi
	optfeature "if you have a version of OpenSSL older than 1.1.1b installed and you want support for Curve25519 key exchange, Ed25519 keys and certificates, or the Chacha20-Poly1305 cipher" dev-python/libnacl
	optfeature "support for UMAC cryptographic hashes" dev-python/libnettle
	optfeature "support for X.509 certificate authentication" dev-python/pyopenssl
}
