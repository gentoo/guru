# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

PYTHON_COMPAT=( python3_{8,9} )

DISTUTILS_USE_SETUPTOOLS=rdepend

inherit distutils-r1

DESCRIPTION="Easily update multiple git repositories at once"
HOMEPAGE="https://github.com/earwig/git-repo-updater"
SRC_URI="https://github.com/earwig/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/colorama-0.3.9[${PYTHON_USEDEP}]
	>=dev-python/GitPython-2.1.8[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest
