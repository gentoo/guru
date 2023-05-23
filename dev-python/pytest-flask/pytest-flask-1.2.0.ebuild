# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_11 pypy3 )
inherit distutils-r1

DESCRIPTION="A set of pytest fixtures to test Flask applications "
HOMEPAGE="http://pytest-flask.readthedocs.org"

inherit git-r3
EGIT_REPO_URI="https://github.com/pytest-dev/${PN}.git"
EGI_COMMIT="1.2.0"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="test"

RDEPEND="
	dev-python/flask[${PYTHON_USEDEP}]
	dev-python/werkzeug[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}
	test? (
		dev-python/mock[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
