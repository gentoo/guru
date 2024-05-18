# Copyright 2021-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1

DESCRIPTION="Typing speed test in terminal"
HOMEPAGE="https://github.com/Mithil467/mitype https://pypi.org/project/mitype/"
SRC_URI="https://github.com/Mithil467/mitype/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

BDEPEND="
	dev-python/versioneer[${PYTHON_USEDEP}]
	doc? (
		dev-python/sphinx-rtd-theme
	)
"

distutils_enable_tests pytest
distutils_enable_sphinx docs/source
