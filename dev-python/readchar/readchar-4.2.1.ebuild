# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 #pypi

DESCRIPTION="Python library to read characters and key strokes"
HOMEPAGE="
	https://github.com/magmax/python-readchar/
	https://pypi.org/project/readchar/
"
# no tests in sdist
SRC_URI="
	https://github.com/magmax/python-readchar/archive/refs/tags/v${PV}.tar.gz
		-> ${P}.gh.tar.gz
"
S="${WORKDIR}/python-readchar-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest

python_test() {
	# --capture=no: required for tests to pass
	# -o addopts=: avoid cov options
	epytest --capture=no -o addopts=
}
