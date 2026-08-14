# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=maturin
PYTHON_COMPAT=( python3_{12..15} )

RUST_MIN_VER="1.88.0"
CRATES="
"

inherit cargo distutils-r1

DESCRIPTION="Fast iterable JSON parser"
HOMEPAGE="
	https://github.com/pydantic/jiter
	https://pypi.org/project/jiter/
"
SRC_URI="
	https://github.com/pydantic/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz
	https://github.com/fasys-crate-dist/${PN}/releases/download/v${PV}/${P}-crates.tar.xz
"
S="${WORKDIR}/${P}/crates/jiter-python"

LICENSE="MIT"
# Dependent crate licenses
LICENSE+="
	Apache-2.0 Apache-2.0-with-LLVM-exceptions MIT MPL-2.0 Unicode-3.0
"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

BDEPEND="
	test? (
		dev-python/dirty-equals[${PYTHON_USEDEP}]
	)
"

QA_FLAGS_IGNORED="usr/lib.*/py.*/site-packages/jiter/jiter.*.so"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
