# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} )
DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1
inherit distutils-r1 optfeature pypi

DESCRIPTION="A UFO font library"
HOMEPAGE="
	https://pypi.org/project/ufoLib2/
	https://github.com/fonttools/ufoLib2
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/attrs-22.1.0[${PYTHON_USEDEP}]
	>=dev-python/fonttools-4.0.0[${PYTHON_USEDEP}]
	>=dev-python/fs-2.2.0[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		>=dev-python/cattrs-22.2.0[${PYTHON_USEDEP}]
		dev-python/msgpack[${PYTHON_USEDEP}]
		dev-python/orjson[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

distutils_enable_sphinx docs/source \
	dev-python/sphinx-rtd-theme

pkg_postinst() {
	optfeature "json support" "dev-python/cattrs dev-python/orjson"
	optfeature "msgpack support" "dev-python/cattrs dev-python/msgpack"
}
