# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7,8,9} )
inherit distutils-r1

DESCRIPTION="Microsoft Azure Blob Storage Client Library for Python"
HOMEPAGE="https://pypi.org/project/azure-storage-blob/"
SRC_URI="https://files.pythonhosted.org/packages/62/c5/2ded1eafb82fe093c9f18db071755288cd646ed02bc87abd160d4b2c23ae/${P}.zip"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
