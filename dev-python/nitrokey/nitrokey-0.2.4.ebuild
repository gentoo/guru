# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{12..13} )

inherit distutils-r1

DESCRIPTION="Python SDK for Nitrokey devices"
HOMEPAGE="https://github.com/Nitrokey/nitrokey-sdk-py https://pypi.org/project/nitrokey/"
SRC_URI="https://github.com/Nitrokey/nitrokey-sdk-py/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/nitrokey-sdk-py-${PV}"
LICENSE="Apache-2.0 MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/crcmod-1.7[${PYTHON_USEDEP}]
	>=dev-python/cryptography-41[${PYTHON_USEDEP}]
	>=dev-python/fido2-1.1.2:=[${PYTHON_USEDEP}]
	>=dev-python/hidapi-0.14[${PYTHON_USEDEP}]
	>=dev-python/protobuf-5.26:=[${PYTHON_USEDEP}]
	>=dev-python/pyserial-3.5[${PYTHON_USEDEP}]
	>=dev-python/requests-2[${PYTHON_USEDEP}]
	>=dev-python/semver-3[${PYTHON_USEDEP}]
	>=dev-python/tlv8-0.10[${PYTHON_USEDEP}]
	>=dev-python/types-protobuf-5.26[${PYTHON_USEDEP}]
	>=dev-python/types-requests-2.32[${PYTHON_USEDEP}]
	>=dev-python/typing-extensions-4[${PYTHON_USEDEP}]
"

distutils_enable_sphinx docs
distutils_enable_tests pytest
