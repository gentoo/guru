# Copyright Gentoo Authors 2024
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..11} )

DESCRIPTION="Unofficial Evernote SDK for Python 3"
HOMEPAGE="
	https://github.com/JackonYang/evernote2
	https://pypi.org/project/evernote2/
"

EGIT_REPO_URI="https://github.com/JackonYang/evernote2"
inherit git-r3 distutils-r1

LICENSE="Apache-2.0"

SLOT="0"

RDEPEND="
	dev-python/oauthlib[${PYTHON_USEDEP}]
	dev-python/thrift[${PYTHON_USEDEP}]
"
