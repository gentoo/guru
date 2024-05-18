# Copyright 2022-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1

DESCRIPTION=" Option groups missing in Click "
HOMEPAGE="https://github.com/click-contrib/click-option-group"
SRC_URI="https://github.com/click-contrib/${PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test"

RDEPEND="dev-python/click[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="
"
# dev-python/coveralls currently masked in ::guru due to
# https://github.com/TheKevJames/coveralls-python/issues/377
	# test? (
	# 	dev-python/pytest-cov[${PYTHON_USEDEP}]
	# 	<dev-python/coverage-7[${PYTHON_USEDEP}]
	# 	dev-python/coveralls[${PYTHON_USEDEP}]
	# )

distutils_enable_tests pytest
