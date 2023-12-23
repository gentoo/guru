# Copyright 2020-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..11} )
DISTUTILS_SINGLE_IMPL=1
inherit distutils-r1

DESCRIPTION="A free and open-source replacement for the Epic Games Launcher"
HOMEPAGE="https://github.com/derrod/legendary"
SRC_URI="https://github.com/derrod/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"
IUSE="webview"

# NOTE: dev-python/pywebview[qt5] is not much tested and does not function
# correctly in some cases, according to release notes for 0.20.16.
RDEPEND="
	$(python_gen_cond_dep '
		dev-python/filelock[${PYTHON_USEDEP}]
		<dev-python/requests-3.0[${PYTHON_USEDEP}]
		webview? ( dev-python/pywebview[gtk,${PYTHON_USEDEP}] )
	')
"
DEPEND="${RDEPEND}"
