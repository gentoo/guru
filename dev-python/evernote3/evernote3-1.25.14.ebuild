# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 pypi

DESCRIPTION="Evernote SDK"
HOMEPAGE="https://github.com/Evernote/evernote-sdk-python3"
KEYWORDS="~amd64 ~x86"

LICENSE="Apache-2.0"
SLOT="0"

RDEPEND="dev-python/oauth2[${PYTHON_USEDEP}]
dev-python/oauthlib[${PYTHON_USEDEP}]
dev-python/requests[${PYTHON_USEDEP}]
dev-python/requests-oauthlib[${PYTHON_USEDEP}]"
