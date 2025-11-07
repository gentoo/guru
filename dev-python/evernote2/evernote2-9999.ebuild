# Copyright Gentoo Authors 2024-2025
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 git-r3

DESCRIPTION="Unofficial Evernote SDK for Python 3"
HOMEPAGE="
	https://github.com/JackonYang/evernote2
	https://pypi.org/project/evernote2/
"
EGIT_REPO_URI="https://github.com/JackonYang/evernote2"

LICENSE="Apache-2.0"

SLOT="0"

BDEPEND="
	test? (
		dev-python/pytest-xdist[${PYTHON_USEDEP}]
		dev-python/pytest-cov[${PYTHON_USEDEP}]
	)
"

RDEPEND="
	dev-python/oauthlib[${PYTHON_USEDEP}]
	dev-python/thrift[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest
