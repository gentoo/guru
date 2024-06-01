# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} )
inherit distutils-r1 pypi

DESCRIPTION="Python interface for libheif library"
HOMEPAGE="
	https://github.com/bigcat88/pillow_heif
	https://pypi.org/project/pillow-heif/
"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	!test? (
		dev-python/pillow[${PYTHON_USEDEP}]
		media-libs/libheif:=
	)
	test? (
		dev-python/pillow[webp,${PYTHON_USEDEP}]
		media-libs/libheif:=[x265]
	)
"

PATCHES=( "${FILESDIR}/${P}-respect-cflags.patch" )

distutils_enable_tests pytest

src_prepare() {
	distutils-r1_src_prepare
	sed -i "s/=get_version()/=\"${PV}\"/" setup.py || die
}
