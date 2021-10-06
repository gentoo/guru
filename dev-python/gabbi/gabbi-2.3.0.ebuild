# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_8 )

inherit distutils-r1

DESCRIPTION="Declarative HTTP testing library"
HOMEPAGE="
	https://github.com/cdent/gabbi
	https://pypi.org/project/gabbi
"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

SLOT="0"
LICENSE="Apache-2.0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/pbr[${PYTHON_USEDEP}]
	dev-python/pytest[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	>=dev-python/urllib3-1.11.0[${PYTHON_USEDEP}]
	dev-python/certifi[${PYTHON_USEDEP}]
	>=dev-python/jsonpath-rw-ext-1.0.0[${PYTHON_USEDEP}]
	>=dev-python/wsgi_intercept-1.8.1[${PYTHON_USEDEP}]
	dev-python/colorama[${PYTHON_USEDEP}]
"
DEPEND="
	${RDEPEND}
	test? (
		dev-python/stestr[${PYTHON_USEDEP}]
		dev-python/hacking[${PYTHON_USEDEP}]
	)
"

RESTRICT="test"
PROPERTIES="test_network"

distutils_enable_tests pytest
