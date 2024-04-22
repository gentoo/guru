# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_10 ) # python3_11 depends on dev-python/black

# Make sure to remove 'libcst', 'libcst_native' from crates list
CRATES="
	aho-corasick-0.7.18
	annotate-snippets-0.6.1
	atty-0.2.14
	autocfg-1.0.1
	bitflags-1.2.1
	bstr-0.2.16
	bumpalo-3.7.0
	cast-0.2.7
	cfg-if-1.0.0
	chic-1.2.2
	clap-2.33.3
	criterion-0.3.4
	criterion-cycles-per-byte-0.1.2
	criterion-plot-0.4.3
	crossbeam-channel-0.5.1
	crossbeam-deque-0.8.1
	crossbeam-epoch-0.9.5
	crossbeam-utils-0.8.8
	csv-1.1.6
	csv-core-0.1.10
	difference-2.0.0
	either-1.6.1
	glob-0.3.0
	half-1.7.1
	hermit-abi-0.1.19
	indoc-0.3.6
	indoc-impl-0.3.6
	instant-0.1.10
	itertools-0.9.0
	itertools-0.10.1
	itoa-0.4.7
	js-sys-0.3.51
	lazy_static-1.4.0
	libc-0.2.98
	lock_api-0.4.4
	log-0.4.14
	memchr-2.4.0
	memoffset-0.6.4
	num-traits-0.2.14
	num_cpus-1.13.0
	once_cell-1.8.0
	oorandom-11.1.3
	parking_lot-0.11.1
	parking_lot_core-0.8.3
	paste-0.1.18
	paste-1.0.5
	paste-impl-0.1.18
	peg-0.8.0
	peg-macros-0.8.0
	peg-runtime-0.8.0
	plotters-0.3.1
	plotters-backend-0.3.2
	plotters-svg-0.3.1
	proc-macro-hack-0.5.19
	proc-macro2-1.0.28
	pyo3-0.14.5
	pyo3-build-config-0.14.5
	pyo3-macros-0.14.5
	pyo3-macros-backend-0.14.5
	quote-1.0.9
	rayon-1.5.1
	rayon-core-1.9.1
	redox_syscall-0.2.9
	regex-1.5.5
	regex-automata-0.1.10
	regex-syntax-0.6.25
	rustc_version-0.4.0
	ryu-1.0.5
	same-file-1.0.6
	scopeguard-1.1.0
	semver-1.0.3
	serde-1.0.126
	serde_cbor-0.11.1
	serde_derive-1.0.126
	serde_json-1.0.64
	smallvec-1.6.1
	syn-1.0.74
	termcolor-1.1.3
	textwrap-0.11.0
	thiserror-1.0.26
	thiserror-impl-1.0.26
	tinytemplate-1.2.1
	toml-0.5.9
	trybuild-1.0.53
	unicode-width-0.1.8
	unicode-xid-0.2.2
	unindent-0.1.7
	walkdir-2.3.2
	wasm-bindgen-0.2.74
	wasm-bindgen-backend-0.2.74
	wasm-bindgen-macro-0.2.74
	wasm-bindgen-macro-support-0.2.74
	wasm-bindgen-shared-0.2.74
	web-sys-0.3.51
	winapi-0.3.9
	winapi-i686-pc-windows-gnu-0.4.0
	winapi-util-0.1.5
	winapi-x86_64-pc-windows-gnu-0.4.0
"

# Current version (0.4.3) has git based rust crates
# https://github.com/Instagram/LibCST/pull/691 updates the rust module to use versioned crates
MY_REV=380f045fe05bfdc6a0555f8e36a0c1c406ca1b77
MY_PN="LibCST"

inherit cargo distutils-r1

DESCRIPTION="Concrete syntax tree parser and serializer for Python"
HOMEPAGE="https://github.com/Instagram/LibCST"
SRC_URI="
	https://github.com/Instagram/LibCST/archive/${MY_REV}.tar.gz -> ${P}.tar.gz
	$(cargo_crate_uris)
"
S="${WORKDIR}/${MY_PN}-${MY_REV}"

LICENSE="MIT Apache-2.0 PSF-2 BSD Boost-1.0 Unlicense"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="test"

RDEPEND="
	>=dev-python/pyyaml-5.2[${PYTHON_USEDEP}]
	>=dev-python/setuptools-rust-0.12.1[${PYTHON_USEDEP}]
	>=dev-python/typing-extensions-3.7.4.2[${PYTHON_USEDEP}]
	>=dev-python/typing-inspect-0.4.0[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"
# 	test? (
# 		~dev-python/black-22.3.0[${PYTHON_USEDEP}]
# 		>=dev-python/hypothesis-4.36.0[${PYTHON_USEDEP}]
# 		>=dev-python/hypothesmith-0.0.4[${PYTHON_USEDEP}]
# 		>=dev-python/prompt-toolkit-2.0.9[${PYTHON_USEDEP}]
# 	)
# "
# BDEPEND="test? ( dev-python/ufmt[${PYTHON_USEDEP}] )"

distutils_enable_tests --install pytest

export SETUPTOOLS_SCM_PRETEND_VERSION=0.4.3

python_test() {
	# Requires `/usr/bin/pyre` from https://github.com/facebook/pyre-check
	local EPYTEST_DESELECT=(
		'libcst/metadata/tests/test_type_inference_provider.py::TypeInferenceProviderTest::test_gen_cache_0'
		'libcst/metadata/tests/test_type_inference_provider.py::TypeInferenceProviderTest::test_simple_class_types_0'
		'libcst/metadata/tests/test_type_inference_provider.py::TypeInferenceProviderTest::test_with_empty_cache'
	)

	run_in_build_dir ${EPYTHON} -m libcst.codegen.generate all
	epytest
}
