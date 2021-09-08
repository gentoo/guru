# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..9} )

inherit distutils-r1

DESCRIPTION="Font quality assurance tool"
HOMEPAGE="
	https://github.com/googlefonts/fontbakery
	https://pypi.org/project/fontbakery
"
SRC_URI="https://github.com/googlefonts/fontbakery/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/beautifulsoup4-4.9.3[${PYTHON_USEDEP}]
	>=dev-python/beziers-0.3.1[${PYTHON_USEDEP}]
	>=dev-python/cmarkgfm-0.5.3[${PYTHON_USEDEP}]
	>=dev-python/collidoscope-0.0.6[${PYTHON_USEDEP}]
	>=dev-python/defcon-0.8.1[${PYTHON_USEDEP}]
	>=dev-python/font-v-1.0.5[${PYTHON_USEDEP}]
	>=dev-python/fonttools-4.24.3[${PYTHON_USEDEP}]
	>=dev-python/lxml-4.6.3[${PYTHON_USEDEP}]
	>=dev-python/pip-api-0.0.20[${PYTHON_USEDEP}]
	>=dev-python/protobuf-python-3.17.0[${PYTHON_USEDEP}]
	>=dev-python/pyyaml-5.4.1[${PYTHON_USEDEP}]
	>=dev-python/requests-2.25.1[${PYTHON_USEDEP}]
	>=dev-python/rich-10.2.2[${PYTHON_USEDEP}]
	>=dev-python/stringbrewer-0.0.1[${PYTHON_USEDEP}]
	>=dev-python/toml-0.10.2[${PYTHON_USEDEP}]
	>=dev-python/vharfbuzz-0.1.1[${PYTHON_USEDEP}]
	>=dev-util/ots-8.1.4
	>=media-gfx/dehinter-3.1.0[${PYTHON_USEDEP}]
	>=media-gfx/ufolint-1.2.0[${PYTHON_USEDEP}]
"
DEPEND="
	${RDEPEND}
	test? (
		dev-python/ufo2ft[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
distutils_enable_sphinx docs/source \
	"<dev-python/sphinx-4.0" \
	dev-python/sphinx_rtd_theme \
	dev-python/recommonmark

pkg_setup() {
	export SETUPTOOLS_SCM_PRETEND_VERSION="${PV}"
}
