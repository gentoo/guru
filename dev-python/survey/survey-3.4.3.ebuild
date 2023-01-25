# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..11} )
inherit distutils-r1

DESCRIPTION="A simple library for creating beautiful interactive prompts"
HOMEPAGE="
	https://github.com/Exahilosys/survey
	https://pypi.org/project/survey/
"
SRC_URI="https://github.com/Exahilosys/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	>=dev-python/wrapio-1.0.0[${PYTHON_USEDEP}]
"
