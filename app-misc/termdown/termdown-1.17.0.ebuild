# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{3_8,3_9} )
inherit distutils-r1

DESCRIPTION="Countdown timer and stopwatch in your terminal"
HOMEPAGE="https://github.com/trehn/termdown"
SRC_URI="https://github.com/trehn/termdown/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"

SLOT="0"

KEYWORDS="~amd64"

IUSE="speak"

DEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/python-dateutil[${PYTHON_USEDEP}]
	dev-python/pyfiglet[${PYTHON_USEDEP}]
	speak? ( app-accessibility/espeak )"

RDEPEND="${DEPEND}"
