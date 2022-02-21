# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9,10} )

inherit distutils-r1

DESCRIPTION="Simple proxy (as in the GoF design pattern)"
HOMEPAGE="https://pypi.org/project/proxy_tools/"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
