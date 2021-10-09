# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8,9} )
inherit distutils-r1

DESCRIPTION="Package for curses-like operations, text UIs and ASCII art animations"
HOMEPAGE="https://pypi.org/project/asciimatics/ https://github.com/peterbrittain/asciimatics"

if [[ "${PV}" == 9999 ]]
then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/peterbrittain/asciimatics.git"
else
	SRC_URI="https://github.com/peterbrittain/asciimatics/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="Apache-2.0"
SLOT="0"

RESTRICT="mirror"

RDEPEND="
	>=dev-python/pyfiglet-0.7.2[${PYTHON_USEDEP}]
	>=dev-python/pillow-2.7.0[${PYTHON_USEDEP}]
	dev-python/wcwidth[${PYTHON_USEDEP}]
	dev-python/future[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		${RDEPEND}
		dev-python/mock
	)
"

distutils_enable_tests nose
