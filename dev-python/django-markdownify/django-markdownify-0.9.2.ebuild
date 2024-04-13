# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1

DESCRIPTION="Markdown template filter for Django"
HOMEPAGE="
	https://pypi.org/project/django-markdownify/
	https://github.com/erwinmatijsen/django-markdownify
"
SRC_URI="https://github.com/erwinmatijsen/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

# No Django settings to run tests
RESTRICT="test"

RDEPEND="
	dev-python/bleach[${PYTHON_USEDEP}]
	dev-python/django[${PYTHON_USEDEP}]
	dev-python/markdown[${PYTHON_USEDEP}]
	dev-python/tinycss2[${PYTHON_USEDEP}]
	!dev-python/markdownify
"
BDEPEND="
	test? ( ${RDEPEND} )
	doc? ( dev-python/sphinx-rtd-theme[${PYTHON_USEDEP}] )
"

distutils_enable_sphinx docs/source --no-autodoc

python_test() {
	"${EPYTHON}" -m django test -v 2 --settings test_app.settings ||
		die "Tests failed with ${EPYTHON}"
}
