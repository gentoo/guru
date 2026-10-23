# Copyright 2022-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	aho-corasick@1.1.5
	anstream@1.0.0
	anstyle-parse@1.0.0
	anstyle-query@1.1.5
	anstyle-wincon@3.0.11
	anstyle@1.0.14
	autocfg@1.5.1
	base64@0.22.1
	bitflags@2.13.2
	borrow-or-share@0.2.4
	boxcar@0.2.14
	bumpalo@3.20.3
	cfg-if@1.0.5
	clap@4.6.7
	clap_builder@4.6.7
	clap_derive@4.6.7
	clap_lex@1.1.1
	colorchoice@1.0.5
	crossbeam-deque@0.8.8
	crossbeam-epoch@0.9.21
	crossbeam-utils@0.8.23
	csv-core@0.1.13
	csv@1.4.0
	cyclonedx-bom-macros@0.1.0
	cyclonedx-bom@0.8.1
	deranged@0.5.9
	displaydoc@0.2.7
	downcast@0.11.0
	either@1.18.0
	equivalent@1.0.2
	errno@0.3.14
	fastrand@2.5.0
	fluent-uri@0.4.1
	foldhash@0.2.0
	form_urlencoded@1.2.2
	fragile@2.1.0
	futures-core@0.3.34
	futures-task@0.3.34
	futures-timer@3.0.4
	futures-util@0.3.34
	getrandom@0.4.3
	glob@0.3.4
	hashbrown@0.17.1
	heck@0.5.0
	hex@0.4.3
	icu_collections@2.1.1
	icu_locale_core@2.1.1
	icu_normalizer@2.1.1
	icu_normalizer_data@2.1.1
	icu_properties@2.1.2
	icu_properties_data@2.1.2
	icu_provider@2.1.1
	idna@1.1.0
	idna_adapter@1.2.1
	indexmap@2.14.2
	is_terminal_polyfill@1.70.2
	itertools@0.13.0
	itoa@1.0.18
	js-sys@0.3.106
	libc@0.2.189
	linux-raw-sys@0.12.1
	litemap@0.8.3
	lock_api@0.4.14
	memchr@2.8.3
	mockall@0.15.0
	mockall_derive@0.15.0
	nab@0.12.4
	num-conv@0.2.2
	num-traits@0.2.19
	once_cell@1.21.4
	once_cell_polyfill@1.70.2
	ordered-float@5.4.0
	parking_lot@0.12.5
	parking_lot_core@0.9.12
	pep440_rs@0.7.3
	pep508_rs@0.9.2
	percent-encoding@2.3.2
	pin-project-lite@0.2.17
	portable-atomic@1.15.0
	potential_utf@0.1.6
	powerfmt@0.2.1
	predicates-core@1.0.10
	predicates-tree@1.0.13
	predicates@3.1.4
	proc-macro-crate@3.5.0
	proc-macro2@1.0.107
	purl@0.1.6
	pyo3-build-config@0.30.1
	pyo3-ffi@0.30.1
	pyo3-macros-backend@0.30.1
	pyo3-macros@0.30.1
	pyo3@0.30.1
	quote@1.0.47
	r-efi@6.0.0
	rayon-core@1.13.0
	rayon@1.12.0
	redox_syscall@0.5.18
	ref-cast-impl@1.0.27
	ref-cast@1.0.27
	regex-automata@0.4.18
	regex-syntax@0.8.11
	regex@1.13.1
	relative-path@1.9.3
	rstest@0.27.0
	rstest_macros@0.27.0
	rustc-hash@2.1.3
	rustc_version@0.4.1
	rustix@1.1.5
	rustversion@1.0.23
	ryu@1.0.23
	scopeguard@1.2.0
	semver@1.0.28
	serde@1.0.229
	serde_core@1.0.229
	serde_derive@1.0.229
	serde_json@1.0.154
	serde_spanned@1.1.1
	slab@0.4.12
	smallvec@1.16.2
	spdx@0.13.6
	stable_deref_trait@1.2.1
	strsim@0.11.1
	strum@0.28.0
	strum_macros@0.28.0
	syn@2.0.119
	syn@3.0.6
	synstructure@0.14.0
	target-lexicon@0.13.5
	temp-env@0.3.6
	tempfile@3.27.0
	termtree@0.5.1
	textwrap@0.16.4
	thiserror-impl@1.0.69
	thiserror-impl@2.0.21
	thiserror@1.0.69
	thiserror@2.0.21
	time-core@0.1.9
	time-macros@0.2.32
	time@0.3.55
	tinystr@0.8.4
	toml@1.1.6+spec-1.1.0
	toml_datetime@1.1.1+spec-1.1.0
	toml_edit@0.25.15+spec-1.1.0
	toml_parser@1.1.3+spec-1.1.0
	toml_writer@1.1.2+spec-1.1.0
	unicode-ident@1.0.26
	unicode-width@0.2.2
	unscanny@0.1.0
	url@2.5.8
	urlencoding@2.1.3
	utf8_iter@1.0.4
	utf8parse@0.2.2
	uuid@1.26.1
	version-ranges@0.1.3
	wasm-bindgen-macro-support@0.2.129
	wasm-bindgen-macro@0.2.129
	wasm-bindgen-shared@0.2.129
	wasm-bindgen@0.2.129
	windows-link@0.2.1
	windows-sys@0.61.2
	winnow@1.0.4
	writeable@0.6.4
	xml-rs@0.8.29
	yoke-derive@0.8.4
	yoke@0.8.3
	zerofrom-derive@0.1.8
	zerofrom@0.1.8
	zerotrie@0.2.5
	zerovec-derive@0.11.6
	zerovec@0.11.8
	zmij@1.0.23
"

DISTUTILS_USE_PEP517=meson-python
DISTUTILS_EXT=1
RUST_MIN_VER=1.99.0
PYTHON_COMPAT=( python3_{12..15} )

inherit cargo distutils-r1 optfeature

DESCRIPTION="Utility for displaying installed packages in a dependency tree"
HOMEPAGE="
	https://github.com/tox-dev/pipdeptree/
	https://pypi.org/project/pipdeptree/
"
SRC_URI="
	https://github.com/tox-dev/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz
	${CARGO_CRATE_URIS}
"

LICENSE="MIT"
# Dependent crate licenses
LICENSE+="
	Apache-2.0 Apache-2.0-with-LLVM-exceptions MIT MIT-0 MPL-2.0
	Unicode-3.0 ZLIB
"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/packaging-23.1[${PYTHON_USEDEP}]
	>=dev-python/nab-0.0.22[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		dev-python/graphviz[${PYTHON_USEDEP}]
		>=dev-python/virtualenv-20.31.1[${PYTHON_USEDEP}]
	)
"

PATCHES=( "${FILESDIR}/disable-codegen-units-strip.patch" )

EPYTEST_PLUGINS=( pytest-{mock,rerunfailures,subprocess,xdist} )
# tests can fail if other packages are being merged simultaneously
EPYTEST_RERUNS=5
EPYTEST_XDIST=1
distutils_enable_tests pytest

src_test() {
	export PIPDEPTREE_VERSION="${PV}"
	cargo_src_test --no-default-features || die

	distutils-r1_src_test
}

src_prepare() {
	distutils-r1_src_prepare

	## upstream lower bounds are meaningless
	sed -i -e 's:>=[0-9.]*,\?::' pyproject.toml || die
}

src_compile() {
	export PIPDEPTREE_VERSION="${PV}"
	distutils-r1_src_compile
}

pkg_postinst() {
	optfeature \
		"visualising the dependency graph with --graph-output" \
		dev-python/graphviz
}
