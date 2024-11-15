# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )
DISTUTILS_USE_PEP517=maturin
CRATES="
	arrayvec@0.7.4
	autocfg@1.3.0
	bitflags@2.5.0
	cfg-if@1.0.0
	either@1.12.0
	heck@0.4.1
	indoc@2.0.5
	inventory@0.3.15
	itertools@0.10.5
	kurbo@0.11.0
	libc@0.2.155
	lock_api@0.4.12
	memoffset@0.9.1
	once_cell@1.19.0
	parking_lot@0.12.3
	parking_lot_core@0.9.10
	portable-atomic@1.6.0
	proc-macro2@1.0.85
	pyo3-build-config@0.21.2
	pyo3-ffi@0.21.2
	pyo3-macros-backend@0.21.2
	pyo3-macros@0.21.2
	pyo3@0.21.2
	quote@1.0.36
	redox_syscall@0.5.1
	scopeguard@1.2.0
	smallvec@1.13.2
	syn@2.0.66
	target-lexicon@0.12.14
	unicode-ident@1.0.12
	unindent@0.2.3
	windows-targets@0.52.5
	windows_aarch64_gnullvm@0.52.5
	windows_aarch64_msvc@0.52.5
	windows_i686_gnu@0.52.5
	windows_i686_gnullvm@0.52.5
	windows_i686_msvc@0.52.5
	windows_x86_64_gnu@0.52.5
	windows_x86_64_gnullvm@0.52.5
	windows_x86_64_msvc@0.52.5
"

inherit distutils-r1 cargo pypi

DESCRIPTION="Python wrapper around Rust kurbo 2D curves library "
HOMEPAGE="https://github.com/simoncozens/kurbopy"
SRC_URI+=" ${CARGO_CRATE_URIS}"

LICENSE="Apache-2.0"
# Dependent crate licenses
LICENSE+=" Apache-2.0-with-LLVM-exceptions MIT Unicode-DFS-2016"
SLOT="0"
KEYWORDS="~amd64"

src_compile() {
	distutils-r1_src_compile
	cargo_src_compile
}

src_install() {
	distutils-r1_src_install
}

distutils_enable_tests pytest

QA_FLAGS_IGNORED="usr/lib/python3\..*/site-packages/kurbopy/kurbopy.*.so"
