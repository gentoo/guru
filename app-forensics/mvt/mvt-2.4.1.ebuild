# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_11 )

inherit distutils-r1
SRC_URI="https://github.com/mvt-project/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64 ~x86"

DESCRIPTION="Forensic traces to identify a potential compromise of Android and iOS devices"
HOMEPAGE="https://github.com/mvt-project/mvt"

LICENSE="MIT"
SLOT="0"

RDEPEND="
	dev-python/adb-shell[${PYTHON_USEDEP}]
	dev-python/biplist[${PYTHON_USEDEP}]
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/iOSbackup[${PYTHON_USEDEP}]
	dev-python/libusb1[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/rich[${PYTHON_USEDEP}]
	dev-python/simplejson[${PYTHON_USEDEP}]
	dev-python/tld[${PYTHON_USEDEP}]
	dev-python/tqdm[${PYTHON_USEDEP}]
"
