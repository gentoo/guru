# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..15} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1

DESCRIPTION="Simple Django model translations without nasty hacks"
HOMEPAGE="
	https://github.com/django-parler/django-parler
	https://pypi.org/project/django-parler/
"
SRC_URI="https://github.com/django-parler/django-parler/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

PATCHES=( "${FILESDIR}"/2.4-disable-failing-tests.patch )

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/django-5.2[${PYTHON_USEDEP}]
"
BDEPEND="
	test? ( ${RDEPEND} )
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest

python_test() {
	PYTHONPATH=. "${EPYTHON}" runtests.py || die "Tests failed with ${EPYTHON}"
}
