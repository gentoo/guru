# Copyright 2020-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )
DISTUTILS_SINGLE_IMPL=1
inherit distutils-r1

DESCRIPTION="A free and open-source replacement for the Epic Games Launcher"
HOMEPAGE="https://legendary.gl/ https://pypi.org/project/legendary-gl/ https://github.com/derrod/legendary"
SRC_URI="https://github.com/derrod/${PN}/archive/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"
IUSE="webview"

RDEPEND="
	$(python_gen_cond_dep '
		dev-python/filelock[${PYTHON_USEDEP}]
		<dev-python/requests-3.0[${PYTHON_USEDEP}]
		webview? ( dev-python/pywebview[${PYTHON_USEDEP}] )
	')
"
