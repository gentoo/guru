# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit pypi distutils-r1

DESCRIPTION="A Pure-Python Real-Time Audio Library"
HOMEPAGE="
	https://pypi.org/project/SoundCard/
	https://github.com/bastibe/SoundCard/
"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="test" # requires a running pulseaudio server

RDEPEND="
	>=dev-python/numpy-1.11[${PYTHON_USEDEP}]
	dev-python/cffi[${PYTHON_USEDEP}]
"
