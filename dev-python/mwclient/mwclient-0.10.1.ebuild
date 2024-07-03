# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{5..12} )

inherit distutils-r1

DESCRIPTION="Unofficial lib for MediaWiki API"
HOMEPAGE="
	https://github.com/mwclient/mwclient
	https://pypi.python.org/pypi/mwclient
"
SRC_URI="https://github.com/$PN/$PN/archive/refs/tags/v$PV.tar.gz -> $P.gh.tar.gz"

LICENSE="MIT"

SLOT="0"
KEYWORDS="~amd64"

BDEPEND="
	test? (
		dev-python/pytest[${PYTHON_USEDEP}]
		dev-python/pytest-cov[${PYTHON_USEDEP}]
		dev-python/responses[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

RDEPEND="
	dev-python/requests-oauthlib[${PYTHON_USEDEP}]
"
