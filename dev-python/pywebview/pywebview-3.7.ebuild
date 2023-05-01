# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1

DESCRIPTION="A lightweight cross-platform wrapper around a webview component"
HOMEPAGE="https://github.com/r0x0r/pywebview"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="gtk qt5"
REQUIRED_USE="|| ( gtk qt5 )"

RDEPEND="
	dev-python/proxy_tools
	gtk? (
		dev-python/pygobject[cairo,${PYTHON_USEDEP}]
		net-libs/webkit-gtk
	)
	qt5? (
		 dev-python/pyside2[${PYTHON_USEDEP},webengine]
		 dev-python/QtPy[${PYTHON_USEDEP},webengine]
	)
"
