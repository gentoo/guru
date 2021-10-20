# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..9} )

inherit distutils-r1

DESCRIPTION="Command line tools for processing and uploading Mapillary imagery"
HOMEPAGE="https://github.com/mapillary/mapillary_tools"
SRC_URI="https://github.com/mapillary/mapillary_tools/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
KEYWORDS="~amd64"
SLOT="0"

RDEPEND="
	>=dev-python/exifread-2.3.2[${PYTHON_USEDEP}]
	>=dev-python/piexif-1.1.3[${PYTHON_USEDEP}]
	>=dev-python/gpxpy-0.9.8[${PYTHON_USEDEP}]
	>=dev-python/pymp4-1.1.0[${PYTHON_USEDEP}]
	>=dev-python/pynmea2-1.12.0[${PYTHON_USEDEP}]
	>=dev-python/requests-2.20.0[${PYTHON_USEDEP}]
	>=dev-python/tqdm-4.0[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]
	dev-python/jsonschema[${PYTHON_USEDEP}]
"
DEPEND="
	${RDEPEND}
	>=dev-python/pillow-8.1.2[${PYTHON_USEDEP}]
	dev-python/pyinstaller[${PYTHON_USEDEP}]
	dev-python/types-python-dateutil[${PYTHON_USEDEP}]
	dev-python/types-pytz[${PYTHON_USEDEP}]
	dev-python/types-requests[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest
