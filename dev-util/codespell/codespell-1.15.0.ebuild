# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 python3_{5,6,7} )
inherit distutils-r1

DESCRIPTION="Check text files for common misspellings"
HOMEPAGE="https://github.com/codespell-project/codespell"
SRC_URI="https://github.com/${PN}-project/${PN}/archive/v${PVR}.tar.gz -> ${P}.tar.gz"

# Code licensed under GPL-2
# Dictionary licensed under CC-BY-SA-3.0
LICENSE="GPL-2 CC-BY-SA-3.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
