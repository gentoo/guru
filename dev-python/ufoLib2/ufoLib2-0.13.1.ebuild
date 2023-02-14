# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
DOCS_DEPEND="
	dev-python/sphinx-rtd-theme
	dev-python/typing-extensions
"
DOCS_DIR="${S}/docs/source"
DOCS_BUILDER="sphinx"
PYTHON_COMPAT=( python3_{8..11} )

inherit distutils-r1 docs

DESCRIPTION="A UFO font library"
HOMEPAGE="
	https://github.com/fonttools/ufoLib2
	https://pypi.org/project/ufoLib2/
"
SRC_URI="https://github.com/fonttools/ufoLib2/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/attrs-20.1.0[${PYTHON_USEDEP}]
	>=dev-python/fonttools-4.0.0[${PYTHON_USEDEP}]
	dev-python/lxml[${PYTHON_USEDEP}]
"
DEPEND="
	${RDEPEND}
	>=dev-python/setuptools_scm-6.2[${PYTHON_USEDEP}]
	test? (
		dev-python/typing-extensions[${PYTHON_USEDEP}]
	)
"

pkg_setup() {
	export SETUPTOOLS_SCM_PRETEND_VERSION="${PV%_*}"
}

distutils_enable_tests pytest
