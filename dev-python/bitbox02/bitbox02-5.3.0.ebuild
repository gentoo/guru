# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..9} )
inherit distutils-r1

DESCRIPTION="Python API for communicating with the BitBox02 device"
HOMEPAGE="https://github.com/digitalbitbox/bitbox02-firmware"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	>=dev-python/base58-2.0.0[${PYTHON_USEDEP}]
	>=dev-python/ecdsa-0.14.0[${PYTHON_USEDEP}]
	>=dev-python/hidapi-0.7.99[${PYTHON_USEDEP}]
	>=dev-python/noiseprotocol-0.3.0[${PYTHON_USEDEP}]
	>=dev-python/protobuf-python-3.7.0[${PYTHON_USEDEP}]
	>=dev-python/semver-2.8.1[${PYTHON_USEDEP}]
	>=dev-python/typing-extensions-3.7.4[${PYTHON_USEDEP}]"
BDEPEND=""
