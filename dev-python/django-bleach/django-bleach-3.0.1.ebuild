# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1

DESCRIPTION="Easily use bleach with Django models and templates"
HOMEPAGE="
	https://pypi.org/project/django-bleach/
	https://github.com/marksweb/django-bleach
"
SRC_URI="https://github.com/marksweb/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	dev-python/bleach[${PYTHON_USEDEP}]
	dev-python/django[${PYTHON_USEDEP}]
	dev-python/tinycss2[${PYTHON_USEDEP}]
"
BDEPEND="
	test? ( ${RDEPEND} )
"

distutils_enable_sphinx docs

python_test() {
	"${EPYTHON}" testproject/manage.py test -v 2 django_bleach
}
