# Copyright 2021-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..11} )
inherit distutils-r1

DESCRIPTION="A simple library for creating beautiful interactive prompts"
HOMEPAGE="
	https://github.com/Exahilosys/survey
	https://pypi.org/project/survey/
"
MY_PV=${PV/_/-}
SRC_URI="https://github.com/Exahilosys/survey/archive/v${MY_PV}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}"/${PN}-${MY_PV}

LICENSE="MIT"
SLOT="0"

BDEPEND="dev-python/setuptools-scm[${PYTHON_USEDEP}]"

distutils_enable_sphinx docs \
	dev-python/sphinx-autodoc-typehints \
	dev-python/sphinx-paramlinks \
	dev-python/sphinx-rtd-theme

src_configure() {
	distutils-r1_src_configure
	export SETUPTOOLS_SCM_PRETEND_VERSION=${PV}
}
