# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..15} )

inherit distutils-r1

DESCRIPTION="Extracts the top level domain (TLD) from the URL given"
HOMEPAGE="https://github.com/barseghyanartur/tld"
SRC_URI="https://github.com/barseghyanartur/tld/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="|| ( MPL-1.1 GPL-2 LGPL-2.1+ )"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="
	test? (
		dev-python/fake[${PYTHON_USEDEP}]
	)
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest

python_test() {
	epytest --override-ini="addopts="
}
