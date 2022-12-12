# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1

DESCRIPTION="Low-level communication layer for PRAW"
HOMEPAGE="https://pypi.org/project/prawcore/ https://github.com/praw-dev/prawcore"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/requests[${PYTHON_USEDEP}]"
BDEPEND="test? (
	<dev-python/betamax-0.9[${PYTHON_USEDEP}]
	<dev-python/betamax-matchers-0.5[${PYTHON_USEDEP}]
	<dev-python/betamax-serializers-0.3[${PYTHON_USEDEP}]
	dev-python/mock[${PYTHON_USEDEP}]
	dev-python/testfixtures[${PYTHON_USEDEP}]
)"

DOCS=( {AUTHORS,CHANGES,README}.rst )

distutils_enable_tests pytest
