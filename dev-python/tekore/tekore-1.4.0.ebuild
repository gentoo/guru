# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_7 )

inherit distutils-r1

DESCRIPTION="Spotify Web API client"
HOMEPAGE="https://tekore.readthedocs.io
	https://github.com/felix-hilden/tekore"
SRC_URI="https://github.com/felix-hilden/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
KEYWORDS="~amd64 ~x86"
SLOT="0"

distutils_enable_sphinx docs/src

# the enable_sphinx fucntion seems to act strange when there is only 1 PYTHON_COMPAT
# repoman says:
# dev-python/tekore/tekore-1.1.0.ebuild: BDEPEND: ~x86(default/linux/x86/17.0/systemd)
# [     'dev-python/sphinx[python_targets_python3_7(-),python_single_target_python3_7(+)]']
# therefore we overwrite the deps that the function adds here:
BDEPEND="doc? (
	dev-python/sphinx[${PYTHON_USEDEP}]
	dev-python/sphinx_rtd_theme[${PYTHON_USEDEP}]
	dev-python/sphinx-autodoc-typehints[${PYTHON_USEDEP}] )"

RDEPEND="dev-python/requests[${PYTHON_USEDEP}]
	dev-python/httpx[${PYTHON_USEDEP}]
	media-sound/spotify"

DOCS="readme.rst"

distutils_enable_tests pytest

python_test() {
	pytest -vv tests/* || die "Tests fail with ${EPYTHON}"
}
