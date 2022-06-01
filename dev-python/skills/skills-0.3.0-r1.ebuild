# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_SETUPTOOLS=bdepend
PYTHON_COMPAT=( python3_{8..9} pypy3 ) # no py10 https://github.com/McLeopold/PythonSkills/issues/11

inherit distutils-r1

DESCRIPTION="Python Implementation of the TrueSkill, Glicko and Elo Ranking Algorithms"
HOMEPAGE="
	https://github.com/McLeopold/PythonSkills
	https://pypi.org/project/skills/
"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.zip"

SLOT="0"
LICENSE="BSD"
KEYWORDS="~amd64"

RDEPEND=""
DEPEND=""
BDEPEND="app-arch/unzip"

distutils_enable_tests setup.py
