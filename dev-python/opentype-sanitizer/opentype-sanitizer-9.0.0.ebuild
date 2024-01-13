# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} )
DISTUTILS_USE_PEP517=setuptools
DISTUTILS_EXT=1
PYPI_NO_NORMALIZE=1
inherit distutils-r1 pypi

DESCRIPTION="Python wrapper for the OpenType Sanitizer"
HOMEPAGE="
	https://pypi.org/project/opentype-sanitizer/
	https://github.com/googlefonts/ots-python
"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	app-arch/lz4:=
	media-libs/woff2
	sys-libs/zlib:=
"
DEPEND="${RDEPEND}
	dev-cpp/gtest
"
BDEPEND="dev-build/meson"

distutils_enable_tests pytest
