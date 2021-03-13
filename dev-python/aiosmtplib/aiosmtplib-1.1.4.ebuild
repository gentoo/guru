# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7,8} )

RESTRICT=mirror

DESCRIPTION="Asynchronous SMTP client for use with asyncio"
HOMEPAGE="https://pypi.org/project/aiosmtplib/ https://github.com/cole/aiosmtplib"
#SRC_URI="https://github.com/cole/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~arm ~arm64 ~amd64 ~x86"



