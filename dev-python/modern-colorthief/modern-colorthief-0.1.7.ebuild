# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=maturin
PYTHON_COMPAT=( python3_{11..13} )

inherit cargo distutils-r1 pypi

DESCRIPTION="Colorthief but with modern codes"
HOMEPAGE="
	https://github.com/baseplate-admin/modern_colorthief
	https://pypi.org/project/modern-colorthief/
"
if [[ ${PKGBUMPING} != ${PVR} ]]; then
	SRC_URI+="
		https://github.com/pastalian/distfiles/releases/download/${P}/${P}-crates.tar.xz
	"
fi

LICENSE="MIT"
# Dependent crate licenses
LICENSE+="
	Apache-2.0-with-LLVM-exceptions BSD-2 BSD MIT Unicode-DFS-2016
	|| ( Apache-2.0 CC0-1.0 )
"
SLOT="0"
KEYWORDS="~amd64"

QA_FLAGS_IGNORED="usr/lib.*/py.*/site-packages/modern_colorthief/modern_colorthief.*.so"

distutils_enable_tests pytest

EPYTEST_IGNORE=(
	examples/test_time.py
)
