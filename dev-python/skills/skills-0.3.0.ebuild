# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

PYTHON_COMPAT=( python3_{8,9} pypy3 )
DISTUTILS_USE_SETUPTOOLS=bdepend

inherit distutils-r1

DESCRIPTION="Python Implementation of the TrueSkill, Glicko and Elo Ranking Algorithms"
HOMEPAGE="
	https://github.com/McLeopold/PythonSkills
	https://pypi.org/project/skills
"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.zip"

SLOT="0"
LICENSE="BSD"
KEYWORDS="~amd64"

RDEPEND=""
DEPEND=""
BDEPEND="app-arch/unzip"

distutils_enable_tests setup.py
