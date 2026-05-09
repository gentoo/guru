# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CARGO_OPTIONAL=1
DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

CRATES="
	aho-corasick@1.1.4
	heck@0.5.0
	libc@0.2.186
	memchr@2.8.0
	once_cell@1.21.4
	portable-atomic@1.13.1
	proc-macro2@1.0.106
	pyo3-build-config@0.28.3
	pyo3-ffi@0.28.3
	pyo3-macros-backend@0.28.3
	pyo3-macros@0.28.3
	pyo3@0.28.3
	quote@1.0.45
	regex-automata@0.4.14
	regex-syntax@0.8.10
	regex@1.12.3
	syn@2.0.117
	target-lexicon@0.13.5
	unicode-ident@1.0.24
"

RUST_MIN_VER="1.83"

inherit cargo distutils-r1 optfeature

DESCRIPTION="A formatter to make your CMake code the real treasure"
HOMEPAGE="https://github.com/BlankSpruce/gersemi"
SRC_URI="
	https://github.com/BlankSpruce/gersemi/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz
	${CARGO_CRATE_URIS}
"

LICENSE="MPL-2.0"
# Dependent crate licenses
LICENSE+="
	Apache-2.0-with-LLVM-exceptions Unicode-3.0
	|| ( Apache-2.0 MIT )
	|| ( MIT Unlicense )
"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/ignore-python[${PYTHON_USEDEP}]
	dev-python/lark[${PYTHON_USEDEP}]
	dev-python/platformdirs[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
"
BDEPEND="
	${RUST_DEPEND}
	dev-python/setuptools-rust[${PYTHON_USEDEP}]

	test? (
		dev-python/pydantic[${PYTHON_USEDEP}]
		dev-vcs/git
	)
"

EPYTEST_DESELECT=(
	tests/test_configuration.py::test_schema_in_repository_is_consistent_with_configuration_definition
)
EPYTEST_PLUGINS=()

distutils_enable_tests pytest

src_unpack() {
	cargo_src_unpack
}

pkg_postinst() {
	optfeature "colorized diffs support" dev-python/colorama
}
