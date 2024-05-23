# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_11 )

inherit distutils-r1

DESCRIPTION="Forensic traces to identify a potential compromise of Android and iOS devices"
HOMEPAGE="https://github.com/mvt-project/mvt"
SRC_URI="https://github.com/mvt-project/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

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
	dev-python/ahocorasick[${PYTHON_USEDEP}]
	dev-python/appdirs[${PYTHON_USEDEP}]
"

src_prepare() {
	rm -rf "${S}/tests"
	distutils-r1_src_prepare
}
