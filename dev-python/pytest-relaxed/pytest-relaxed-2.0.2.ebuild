# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )
inherit distutils-r1

DESCRIPTION="Relaxed test discovery for pytest"
HOMEPAGE="https://github.com/bitprophet/pytest-relaxed https://pypi.org/project/pytest-relaxed"
SRC_URI="https://github.com/bitprophet/pytest-relaxed/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="
	test? (
		dev-python/decorator[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
