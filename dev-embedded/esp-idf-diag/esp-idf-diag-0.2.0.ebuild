# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="A tool to gather diagnostic information about the ESP-IDF environment."
HOMEPAGE="https://github.com/espressif/esp-idf-diag"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/rich[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"

BDEPEND="test? ( dev-embedded/esp-idf )"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
