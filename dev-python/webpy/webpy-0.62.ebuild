# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1

DESCRIPTION="A web framework for python that is as simple as it is powerful"
HOMEPAGE="
	https://webpy.org
	https://github.com/webpy/webpy
	https://pypi.org/project/web.py/
"
SRC_URI="https://github.com/${PN}/${PN}/archive/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/cheroot[${PYTHON_USEDEP}]"

EPYTEST_IGNORE=(
	# TODO: tests require postgresql and mysql running
	rm tests/test_db.py
)

EPYTEST_DESELECT=(
	# https://github.com/webpy/webpy/issues/712
	# https://github.com/webpy/webpy/issues/713
	tests/test_application.py::ApplicationTest::test_routing
	tests/test_session.py::DiskStoreTest::testStoreConcurrent
)

distutils_enable_tests pytest

distutils_enable_sphinx docs
