# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 pypi

DESCRIPTION="Read GCS, ABS and local paths with the same interface, tensorflow.io.gfile clone"
HOMEPAGE="
	https://github.com/blobfile/blobfile
	https://pypi.org/project/blobfile/
"

LICENSE="Unlicense"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"
PROPERTIES="test_network"
RESTRICT="test"

RDEPEND="
	>=dev-python/filelock-3.0[${PYTHON_USEDEP}]
	>=dev-python/lxml-4.9[${PYTHON_USEDEP}]
	>=dev-python/pycryptodome-3.8[${PYTHON_USEDEP}]
	>=dev-python/urllib3-2[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		dev-python/xmltodict[${PYTHON_USEDEP}]
	)
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest

python_prepare() {
	sed -e 's/pycryptodomex/pycryptodome/' -i pyproject.toml || die
	sed -e 's/from Cryptodome/from Crypto/' -i blobfile/_gcp.py || die
}
