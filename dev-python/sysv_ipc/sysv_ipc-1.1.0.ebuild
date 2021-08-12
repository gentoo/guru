# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} )
inherit distutils-r1

DESCRIPTION="System V IPC primitives for python"
HOMEPAGE="http://semanchuk.com/philip/sysv_ipc/"
SRC_URI="http://semanchuk.com/philip/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

DOCS=( README ReadMe.html history.html )

distutils_enable_tests unittest
