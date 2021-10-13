# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8,9} )
inherit distutils-r1

DESCRIPTION="A friendly face on SFTP"
HOMEPAGE="https://pypi.org/project/pysftp/"
SRC_URI="https://files.pythonhosted.org/packages/36/60/45f30390a38b1f92e0a8cf4de178cd7c2bc3f874c85430e40ccf99df8fe7/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
