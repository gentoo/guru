# Copyright 2020-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 pypi

DESCRIPTION="A lightweight cross-platform wrapper around a webview component"
HOMEPAGE="https://pywebview.flowrl.com/ https://pypi.org/project/pywebview/ https://github.com/r0x0r/pywebview"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+gtk qt6 ssl"
REQUIRED_USE="|| ( gtk qt6 )"

RDEPEND="
	dev-python/bottle[${PYTHON_USEDEP}]
	dev-python/proxy_tools[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]
	gtk? (
		dev-python/pygobject:3[${PYTHON_USEDEP}]
		net-libs/webkit-gtk
	)
	qt6? (
		dev-python/pyqt6[${PYTHON_USEDEP}]
		dev-python/pyqt6-webengine[${PYTHON_USEDEP}]
		dev-python/qtpy[${PYTHON_USEDEP}]
	)
	ssl? ( dev-python/cryptography[${PYTHON_USEDEP}] )
"

distutils_enable_tests pytest

RESTRICT="test" # FIXME: tests fail without message
