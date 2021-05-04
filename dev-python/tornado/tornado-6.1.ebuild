# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )

inherit distutils-r1

DESCRIPTION="Spotify Web API client"
HOMEPAGE="https://www.tornadoweb.org/en/stable/ https://pypi.org/project/tornado/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0 CC-BY-SA-3.0"
KEYWORDS="~amd64 ~x86"
SLOT="0"
RESTRICT="test" # only works on py2.7
