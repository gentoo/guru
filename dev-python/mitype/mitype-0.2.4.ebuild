# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1

DESCRIPTION="Typing speed test in terminal"
HOMEPAGE="https://github.com/Mithil467/mitype https://pypi.org/project/mitype/"
SRC_URI="https://github.com/Mithil467/mitype/archive/refs/tags/v${PV}.tar.gz -> v${PV}.gh.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]"
BDEPEND="dev-python/versioneer[${PYTHON_USEDEP}]"

distutils_enable_tests pytest
