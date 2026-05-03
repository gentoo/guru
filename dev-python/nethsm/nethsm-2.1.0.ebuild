# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{11..14} )
inherit distutils-r1

DESCRIPTION="Python client for NitroKey NetHSM"
HOMEPAGE="https://github.com/Nitrokey/nethsm-sdk-py"
MY_PN="nethsm-sdk-py"
MY_P="${MY_PN}-${PV}"
SRC_URI="https://github.com/Nitrokey/${MY_PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/certifi[${PYTHON_USEDEP}]
	>=dev-python/cryptography-41[${PYTHON_USEDEP}]
	=dev-python/python-dateutil-2*[${PYTHON_USEDEP}]
	=dev-python/typing-extensions-4*[${PYTHON_USEDEP}]
	=dev-python/urllib3-2*[${PYTHON_USEDEP}]
"

# tests require docker (provision a NetHSM instance in a container from a prebuilt image)
RESTRICT="test"
