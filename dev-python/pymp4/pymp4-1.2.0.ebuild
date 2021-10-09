# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1

DESCRIPTION="A Python MP4 Parser and toolkit"
HOMEPAGE="
	https://github.com/beardypig/pymp4
	https://pypi.org/project/pymp4
"
SRC_URI="https://github.com/beardypig/pymp4/archive/${PV}.tar.gz  -> ${P}.tar.gz"

KEYWORDS="~amd64"
LICENSE="Apache-2.0"
SLOT="0"

RDEPEND="dev-python/construct[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"

distutils_enable_tests pytest
