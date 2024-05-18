# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1

DESCRIPTION="Subcommand REPL for click apps"
HOMEPAGE="
	https://github.com/click-contrib/click-repl
	https://pypi.org/project/click-repl/
"
SRC_URI="https://github.com/click-contrib/click-repl/archive/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/prompt-toolkit[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest
