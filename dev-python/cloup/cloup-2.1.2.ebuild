# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1

DESCRIPTION="Click + option groups + constraints + aliases + help themes + ..."
HOMEPAGE="https://github.com/janluke/cloup https://pypi.org/project/cloup/"
SRC_URI="https://github.com/janluke/cloup/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/click-8.0[${PYTHON_USEDEP}]
	<dev-python/click-9.0[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-python/setuptools-scm[${PYTHON_USEDEP}]
"
# BDEPEND="
# 	doc? (
# 		dev-python/sphinx-autoapi[${PYTHON_USEDEP}]
# 		dev-python/sphinx-panels[${PYTHON_USEDEP}]
# 		dev-python/sphinx-copybutton[${PYTHON_USEDEP}]
# 		dev-python/sphinx-version-warning[${PYTHON_USEDEP}]
# 		dev-python/sphinx-issues[${PYTHON_USEDEP}]
# 	)

distutils_enable_tests pytest
# distutils_enable_sphinx docs # The doc need dev-python/sphinx < 5, which we don't have

src_prepare() {
	default
	export SETUPTOOLS_SCM_PRETEND_VERSION=${PV}
}
