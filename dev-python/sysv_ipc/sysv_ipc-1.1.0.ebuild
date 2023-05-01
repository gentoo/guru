# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} pypy3 )

inherit distutils-r1

DESCRIPTION="System V IPC primitives for python"
HOMEPAGE="
	https://pypi.org/project/sysv-ipc/
	https://semanchuk.com/philip/sysv_ipc/
"
SRC_URI="https://semanchuk.com/philip/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

DOCS=( README ReadMe.html history.html )

distutils_enable_tests unittest
