# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} )
DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1
inherit edo distutils-r1 pypi

DESCRIPTION="PKCS#11 (Cryptoki) support for Python"
HOMEPAGE="
	https://pypi.org/project/python-pkcs11/
	https://github.com/danni/python-pkcs11
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	>=dev-python/asn1crypto-1.0.0[${PYTHON_USEDEP}]
	dev-python/cached-property[${PYTHON_USEDEP}]
"
BDEPEND="
	dev-python/cython[${PYTHON_USEDEP}]
	dev-python/setuptools-scm[${PYTHON_USEDEP}]
	test? (
		dev-libs/openssl
		dev-libs/softhsm
		dev-python/cryptography[${PYTHON_USEDEP}]
		dev-python/oscrypto[${PYTHON_USEDEP}]
		dev-python/parameterized[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

distutils_enable_sphinx docs

python_test() {
	cd "${S}" || die
	epytest
}

src_test() {
	local -x PKCS11_MODULE="${BROOT}/usr/$(get_libdir)/softhsm/libsofthsm2.so"
	local -x PKCS11_TOKEN_LABEL="TEST"
	local -x PKCS11_TOKEN_PIN="1234"
	local -x PKCS11_TOKEN_SO_PIN="5678"

	mkdir -p "${HOME}/.config/softhsm2" || die
	cat > "${HOME}/.config/softhsm2/softhsm2.conf" <<- EOF || die "Failed to create config"
		directories.tokendir = ${T}
		objectstore.backend = file
	EOF

	edo softhsm2-util --init-token --free \
		--label ${PKCS11_TOKEN_LABEL} \
		--pin ${PKCS11_TOKEN_PIN} \
		--so-pin ${PKCS11_TOKEN_SO_PIN}

	rm -r pkcs11 || die
	distutils-r1_src_test
}
