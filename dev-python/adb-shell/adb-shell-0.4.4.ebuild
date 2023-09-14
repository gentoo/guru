# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_11 )

inherit distutils-r1

DESCRIPTION="A Python implementation of ADB with shell and FileSync functionality."
HOMEPAGE="https://pypi.org/project/adb-shell/ https://github.com/JeffLIrion/adb_shell"
SRC_URI="https://github.com/JeffLIrion/adb_shell/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

S="${WORKDIR}/adb_shell-${PV}"

RDEPEND="
	dev-python/aiofiles[${PYTHON_USEDEP}]
	dev-python/cryptography[${PYTHON_USEDEP}]
	dev-python/pyasn1[${PYTHON_USEDEP}]
	dev-python/rsa[${PYTHON_USEDEP}]
"
DEPEND="test? (
	${RDEPEND}
	dev-python/pycryptodome[${PYTHON_USEDEP}]
	dev-python/libusb1[${PYTHON_USEDEP}]

)"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

distutils_enable_tests unittest
