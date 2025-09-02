# Copyright 2021-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..13} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

DESCRIPTION="Sends virtual input commands"
HOMEPAGE="https://github.com/moses-palmer/pynput https://pypi.org/project/pynput"
RDEPEND="
	dev-python/evdev[${PYTHON_USEDEP}]
	X? ( dev-python/python-xlib[${PYTHON_USEDEP}] )
	dev-python/six[${PYTHON_USEDEP}]
"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
IUSE="X"

PATCHES=(
	# issue # 657
	"${FILESDIR}/patches/uinput.patch"
	# Remove deprecated bdist_wheel.universal
	"${FILESDIR}/patches/wheel.patch"
)
