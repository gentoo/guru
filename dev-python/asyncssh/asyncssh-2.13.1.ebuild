# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 optfeature pypi

DESCRIPTION="Asynchronous SSHv2 client and server library"
HOMEPAGE="
	https://asyncssh.timeheart.net
	https://pypi.org/project/asyncssh/
	https://github.com/ronf/asyncssh
"

LICENSE="ECL-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	>=dev-python/cryptography-3.1[${PYTHON_USEDEP}]
	>=dev-python/typing-extensions-3.6[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		dev-python/aiofiles[${PYTHON_USEDEP}]
		>=dev-python/bcrypt-3.1.3[${PYTHON_USEDEP}]
		>=dev-python/fido2-0.9.2[${PYTHON_USEDEP}]
		>=dev-python/gssapi-1.2.0[${PYTHON_USEDEP}]
		>=dev-python/libnacl-1.4.2[${PYTHON_USEDEP}]
		>=dev-python/pyopenssl-17.0.0[${PYTHON_USEDEP}]
		>=dev-python/python-pkcs11-0.7.0[${PYTHON_USEDEP}]
		dev-python/uvloop[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

distutils_enable_sphinx docs

pkg_postinst() {
	optfeature "OpenSSH private key encryption support" dev-python/bcrypt
	optfeature "key exchange and authentication with U2F/FIDO2 security keys support" dev-python/fido2
	optfeature "accessing PIV keys on PKCS#11 security tokens support" dev-python/python-pkcs11
	optfeature "GSSAPI key exchange and authentication support" dev-python/gssapi
	optfeature "UMAC cryptographic hashes support" dev-python/libnettle
	optfeature "X.509 certificate authentication support" dev-python/pyopenssl
}
