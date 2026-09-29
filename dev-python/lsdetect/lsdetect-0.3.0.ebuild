# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	autocfg@1.5.1
	crossbeam-deque@0.8.8
	crossbeam-epoch@0.9.21
	crossbeam-utils@0.8.23
	either@1.18.0
	heck@0.5.0
	libc@0.2.189
	matrixmultiply@0.3.11
	ndarray@0.17.2
	num-complex@0.4.6
	num-integer@0.1.47
	num-traits@0.2.19
	numpy@0.29.0
	once_cell@1.21.4
	portable-atomic@1.15.0
	portable-atomic-util@0.2.8
	proc-macro2@1.0.107
	pyo3@0.29.2
	pyo3-build-config@0.29.2
	pyo3-ffi@0.29.2
	pyo3-macros@0.29.2
	pyo3-macros-backend@0.29.2
	quote@1.0.47
	rawpointer@0.2.1
	rayon@1.12.0
	rayon-core@1.13.0
	rustc-hash@2.1.3
	syn@2.0.119
	target-lexicon@0.13.5
	unicode-ident@1.0.26
"
RUST_MIN_VER="1.88.0"

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=maturin
PYTHON_COMPAT=( python3_{12..15} )

inherit cargo distutils-r1

DESCRIPTION="Line segment detector (LSD) in pure Rust, with Python bindings"
HOMEPAGE="
	https://github.com/p5k369/lsdetect
	https://pypi.org/project/lsdetect/
"
SRC_URI="
	https://github.com/p5k369/lsdetect/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz
	${CARGO_CRATE_URIS}
"

LICENSE="|| ( Apache-2.0 MIT )"
# Dependent crate licenses
LICENSE+="
	Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD-2 MIT Unicode-3.0
"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/numpy[${PYTHON_USEDEP}]"

QA_FLAGS_IGNORED="usr/lib/python.*/site-packages/lsdetect/.*\.so"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
