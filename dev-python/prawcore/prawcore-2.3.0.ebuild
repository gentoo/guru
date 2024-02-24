# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

DESCRIPTION="Low-level communication layer for PRAW"
HOMEPAGE="
	https://pypi.org/project/prawcore/
	https://github.com/praw-dev/prawcore
"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"

# Tests require <dev-python/betamax-0.9 which is no longer available in ::gentoo
RESTRICT="test"

RDEPEND="dev-python/requests[${PYTHON_USEDEP}]"
BDEPEND="
	test? (
		<dev-python/betamax-matchers-0.5[${PYTHON_USEDEP}]
		<dev-python/betamax-serializers-0.3[${PYTHON_USEDEP}]
		dev-python/mock[${PYTHON_USEDEP}]
		dev-python/testfixtures[${PYTHON_USEDEP}]
	)
"

DOCS=( {AUTHORS,CHANGES,README}.rst )

distutils_enable_tests pytest
