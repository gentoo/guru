# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} pypy3 )
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

RDEPEND="dev-python/python-json-logger[${PYTHON_USEDEP}]"
BDEPEND="dev-python/setuptools-scm[${PYTHON_USEDEP}]"

distutils_enable_tests pytest

distutils_enable_sphinx doc/source

pkg_postinst() {
	optfeature "journald support" dev-python/python-systemd
}
