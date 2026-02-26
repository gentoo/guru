# Copyright 2024-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )
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
	dev-python/pillow[${PYTHON_USEDEP}]
	>=media-libs/libheif-1.19.5:=
"
BDEPEND="
	test? (
		dev-python/defusedxml[${PYTHON_USEDEP}]
		dev-python/numpy[${PYTHON_USEDEP}]
		dev-python/pillow[jpeg,lcms,webp,zlib,${PYTHON_USEDEP}]
		>=media-libs/libheif-1.19.5:=[x265]
		media-libs/opencv[png,python,${PYTHON_USEDEP}]
	)
"

PATCHES=( "${FILESDIR}/${PN}-0.21.0-respect-cflags.patch" )

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
