# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7,8,9} )
inherit distutils-r1

DESCRIPTION="Microsoft Azure Blob Storage Client Library for Python"
HOMEPAGE="https://pypi.org/project/azure-storage-blob/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.zip"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="app-arch/unzip"
