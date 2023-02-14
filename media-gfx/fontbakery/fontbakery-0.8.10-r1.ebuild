# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_10 )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1

DESCRIPTION="Font quality assurance tool"
HOMEPAGE="
	https://github.com/googlefonts/fontbakery
	https://pypi.org/project/fontbakery/
"
SRC_URI="https://github.com/googlefonts/fontbakery/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/axisregistry-0.3.9[${PYTHON_USEDEP}]
	>=dev-python/beautifulsoup4-4.11.1[${PYTHON_USEDEP}]
	>=dev-python/beziers-0.4.0[${PYTHON_USEDEP}]
	>=dev-python/cmarkgfm-2022.10.27[${PYTHON_USEDEP}]
	>=dev-python/collidoscope-0.4.1[${PYTHON_USEDEP}]
	>=dev-python/defcon-0.10.1[${PYTHON_USEDEP}]
	>=dev-python/font-v-2.1.0[${PYTHON_USEDEP}]
	>=dev-python/fonttools-4.38.0[${PYTHON_USEDEP}]
	>=dev-python/gflanguages-0.4.0[${PYTHON_USEDEP}]
	>=dev-python/glyphsets-0.5.0[${PYTHON_USEDEP}]
	>=dev-python/lxml-4.9.1[${PYTHON_USEDEP}]
	>=dev-python/opentypespec-1.8.4[${PYTHON_USEDEP}]
	>=dev-python/packaging-21.3[${PYTHON_USEDEP}]
	>=dev-python/pip-api-0.0.29[${PYTHON_USEDEP}]
	>=dev-python/protobuf-python-3.20.1[${PYTHON_USEDEP}]
	>=dev-python/pyyaml-6.0[${PYTHON_USEDEP}]
	>=dev-python/requests-2.28.0[${PYTHON_USEDEP}]
	>=dev-python/rich-12.4.4[${PYTHON_USEDEP}]
	>=dev-python/stringbrewer-0.0.1[${PYTHON_USEDEP}]
	>=dev-python/unicodedata2-14.0.0[${PYTHON_USEDEP}]
	>=dev-python/ufo2ft-2.27.0[${PYTHON_USEDEP}]
	>=dev-python/vharfbuzz-0.1.3[${PYTHON_USEDEP}]
	>=dev-util/ots-8.1.4
	>=media-gfx/dehinter-4.0.0[${PYTHON_USEDEP}]
	>=media-gfx/ufolint-1.2.0[${PYTHON_USEDEP}]
"
DEPEND="
	${RDEPEND}
	test? (
		dev-python/kurbopy[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
# distutils_enable_sphinx docs/source \
# 	"<dev-python/sphinx-4.0" \
# 	dev-python/sphinx-rtd-theme \
# 	dev-python/recommonmark

pkg_setup() {
	export SETUPTOOLS_SCM_PRETEND_VERSION="${PV}"
}
