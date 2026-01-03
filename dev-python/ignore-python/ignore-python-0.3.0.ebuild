# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=maturin
PYTHON_COMPAT=(python3_{11..14})

inherit cargo distutils-r1

DESCRIPTION="Rust ignore crate Python bindings"
HOMEPAGE="
	https://github.com/borsattoz/ignore-python
	https://pypi.org/project/ignore-python/
"
SRC_URI="
	https://github.com/borsattoz/ignore-python/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz
	https://gitlab.com/api/v4/projects/69517529/packages/generic/${PN}/${PV}/${P}-deps.tar.xz
"

LICENSE="MIT Unicode-3.0 Apache-2.0-with-LLVM-exceptions"
SLOT="0"
KEYWORDS="~amd64"

distutils_enable_tests pytest

python_test() {
	epytest --override-ini="pythonpath=${BUILD_DIR}/install$(python_get_sitedir)"
}
