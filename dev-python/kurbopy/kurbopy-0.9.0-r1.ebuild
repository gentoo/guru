# Copyright 2022-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} )
DISTUTILS_USE_PEP517=maturin
CRATES="
	arrayvec-0.7.2
	autocfg-1.1.0
	bitflags-1.2.1
	cfg-if-1.0.0
	either-1.6.1
	indoc-1.0.6
	instant-0.1.9
	itertools-0.10.3
	kurbo-0.9.0
	libc-0.2.88
	lock_api-0.4.2
	memoffset-0.8.0
	once_cell-1.8.0
	parking_lot-0.11.1
	parking_lot_core-0.8.3
	proc-macro2-1.0.24
	pyo3-0.18.1
	pyo3-build-config-0.18.1
	pyo3-ffi-0.18.1
	pyo3-macros-0.18.1
	pyo3-macros-backend-0.18.1
	quote-1.0.9
	redox_syscall-0.2.5
	scopeguard-1.1.0
	smallvec-1.6.1
	syn-1.0.62
	target-lexicon-0.12.4
	unicode-xid-0.2.1
	unindent-0.1.7
	winapi-0.3.9
	winapi-i686-pc-windows-gnu-0.4.0
	winapi-x86_64-pc-windows-gnu-0.4.0
"

inherit distutils-r1 cargo pypi

DESCRIPTION="Python wrapper around Rust kurbo 2D curves library "
HOMEPAGE="https://github.com/simoncozens/kurbopy"
SRC_URI+=" $(cargo_crate_uris)"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="${RDEPEND}"

src_compile() {
	distutils-r1_src_compile
	cargo_src_compile
}

src_install() {
	distutils-r1_src_install
}

distutils_enable_tests pytest

QA_FLAGS_IGNORED="usr/lib/python3\..*/site-packages/kurbopy/kurbopy.*.so"
