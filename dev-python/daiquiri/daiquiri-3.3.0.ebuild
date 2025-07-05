# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..13} pypy3_11 )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 optfeature pypi

DESCRIPTION="Library to configure Python logging easily"
HOMEPAGE="
	https://pypi.org/project/daiquiri/
	https://github.com/Mergifyio/daiquiri
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=dev-python/python-json-logger-3[${PYTHON_USEDEP}]"
BDEPEND="dev-python/setuptools-scm[${PYTHON_USEDEP}]"

EPYTEST_PLUGINS=( )

distutils_enable_tests pytest

distutils_enable_sphinx doc/source

pkg_postinst() {
	optfeature "journald support" dev-python/python-systemd
}
