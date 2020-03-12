# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7} )

inherit distutils-r1

DESCRIPTION="Spotify Web API client"
HOMEPAGE="https://tekore.readthedocs.io
	https://github.com/felix-hilden/tekore"
SRC_URI="https://github.com/felix-hilden/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
KEYWORDS="~amd64 ~x86"
SLOT="0"

# tests fail with py3_6
RESTRICT="python_targets_python3_6? ( test )"

RDEPEND="
	dev-python/requests[${PYTHON_USEDEP}]
	~dev-python/httpx-0.11.1[${PYTHON_USEDEP}]
	media-sound/spotify
	python_targets_python3_6? ( dev-python/dataclasses[python_targets_python3_6] )"

DOCS="readme.rst"

distutils_enable_tests pytest
distutils_enable_sphinx docs/src dev-python/sphinx_rtd_theme dev-python/sphinx-autodoc-typehints

python_test() {
	pytest -vv tests/* || die "Tests fail with ${EPYTHON}"
}
