# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 pypi

DESCRIPTION="Single function module with no dependencies for playing sounds"
HOMEPAGE="
	https://pypi.org/project/playsound/
	https://github.com/TaylorSMarks/playsound
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

RDEPEND="dev-python/gst-python[${PYTHON_USEDEP}]"

PATCHES=(
	"${FILESDIR}/${P}-pep517.patch"
)
