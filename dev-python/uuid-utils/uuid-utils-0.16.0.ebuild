# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
"
RUST_MIN_VER="1.87.0"

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=maturin
PYTHON_COMPAT=( python3_{12..15} )
inherit cargo distutils-r1 pypi

DESCRIPTION="Fast, drop-in replacement for Python's uuid module, powered by Rust."
HOMEPAGE="
	https://aminalaee.github.io/uuid-utils/
	https://github.com/aminalaee/uuid-utils
	https://pypi.org/project/uuid_utils/
"
if [[ ${PKGBUMPING} != ${PVR} ]]; then
	SRC_URI+="
		https://gitlab.com/api/v4/projects/32909921/packages/generic/${PN}/${PV}/${P}-crates.tar.xz
		${CARGO_CRATE_URIS}
	"
fi

LICENSE="BSD"
# Dependent crate licenses
LICENSE+="
	Apache-2.0-with-LLVM-exceptions BSD MIT Unicode-DFS-2016 ZLIB
"
SLOT="0"
KEYWORDS="~amd64"

QA_FLAGS_IGNORED="/usr/lib/python.*/site-packages/uuid_utils/.*.so"

EPYTEST_PLUGINS=()
EPYTEST_DESELECT=(
	# Network sandbox probably messes with it
	# https://github.com/aminalaee/uuid-utils/issues/99#issuecomment-3666565390
	tests/test_uuid.py::test_getnode
)
EPYTEST_IGNORE=(
	# Benchmarking doesn't make sense in an ebuild
	tests/test_benchmarks.py
)
distutils_enable_tests pytest
