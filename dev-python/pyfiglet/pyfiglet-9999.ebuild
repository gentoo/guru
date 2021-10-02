# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..9} )
inherit distutils-r1

DESCRIPTION="Pure-python FIGlet implementation"
HOMEPAGE="https://pypi.org/project/pyfiglet/ https://github.com/pwaller/pyfiglet"

if [[ "${PV}" == 9999 ]]
then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/pwaller/pyfiglet.git"
else
	MY_PV="$(ver_cut 1-2).post$(ver_cut 4)"
	MY_P="${PN}-${MY_PV}"
	S="${WORKDIR}/${MY_P}"
	SRC_URI="https://files.pythonhosted.org/packages/source/p/pyfiglet/${MY_P}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="MIT"
SLOT="0"

RESTRICT="mirror test"
