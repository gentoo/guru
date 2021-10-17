# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9,10} )

inherit distutils-r1

DESCRIPTION="A lightweight cross-platform wrapper around a webview component"
HOMEPAGE="https://github.com/r0x0r/pywebview"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
IUSE="gtk qt5"
REQUIRED_USE="|| ( gtk qt5 )"

RDEPEND="
	gtk? (
		dev-python/pygobject[cairo,${PYTHON_USEDEP}]
		net-libs/webkit-gtk
	)
	qt5? ( dev-python/PyQtWebEngine[${PYTHON_USEDEP}] )
"
