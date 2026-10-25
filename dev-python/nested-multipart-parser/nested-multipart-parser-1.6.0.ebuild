# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..15} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1

DESCRIPTION="Parser for nested data in multipart form"
HOMEPAGE="
	https://github.com/remigermain/nested-multipart-parser
	https://pypi.org/project/nested-multipart-parser/
"
SRC_URI="https://github.com/remigermain/nested-multipart-parser/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="
	test? (
		dev-python/django[${PYTHON_USEDEP}]
		dev-python/djangorestframework[${PYTHON_USEDEP}]
	)
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
