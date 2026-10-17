# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..15} )

inherit distutils-r1

DESCRIPTION="Minimalistic, standalone alternative fake data generator with no dependencies"
HOMEPAGE="https://github.com/barseghyanartur/fake.py"
SRC_URI="https://github.com/barseghyanartur/fake.py/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/fake.py-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="
	test? (
		dev-python/django[${PYTHON_USEDEP}]
	)
"

EPYTEST_PLUGINS=( pytest-codeblock pytest-django )
distutils_enable_tests pytest

python_test() {
	epytest --override-ini="addopts="
}
