# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_SETUPTOOLS=rdepend
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1

DESCRIPTION="Easily update multiple git repositories at once"
HOMEPAGE="https://github.com/earwig/git-repo-updater"
SRC_URI="https://github.com/earwig/${PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/colorama-0.3.9[${PYTHON_USEDEP}]
	>=dev-python/GitPython-2.1.8[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest
