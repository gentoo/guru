# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CARGO_OPTIONAL=1
DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{11..13} )

CRATES="
	autocfg@1.4.0
	base16ct@0.2.0
	base64ct@1.6.0
	block-buffer@0.10.4
	cfg-if@1.0.0
	cipher@0.4.4
	cpufeatures@0.2.16
	crypto-common@0.1.6
	curve25519-dalek-derive@0.1.1
	curve25519-dalek@4.1.3
	digest@0.10.7
	ed25519-dalek@2.1.1
	ed25519@2.2.3
	fiat-crypto@0.2.9
	generic-array@0.14.7
	heck@0.5.0
	indoc@2.0.5
	inout@0.1.3
	libc@0.2.169
	memoffset@0.9.1
	once_cell@1.20.2
	pem-rfc7468@0.7.0
	portable-atomic@1.10.0
	proc-macro2@1.0.92
	pyo3-build-config@0.24.0
	pyo3-ffi@0.24.0
	pyo3-macros-backend@0.24.0
	pyo3-macros@0.24.0
	pyo3@0.24.0
	quote@1.0.38
	rand_core@0.6.4
	rustc_version@0.4.1
	semver@1.0.24
	sha2@0.10.8
	signature@2.2.0
	ssh-cipher@0.2.0
	ssh-encoding@0.2.0
	ssh-key@0.6.7
	subtle@2.6.1
	syn@2.0.96
	target-lexicon@0.13.2
	typenum@1.17.0
	unicode-ident@1.0.14
	unindent@0.2.3
	version_check@0.9.5
	zeroize@1.8.1
"

inherit cargo distutils-r1

DESCRIPTION="Unified launcher for Windows games on Linux"
HOMEPAGE="https://github.com/Open-Wine-Components/umu-launcher"
SRC_URI="
	https://github.com/Open-Wine-Components/umu-launcher/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz
	${CARGO_CRATE_URIS}
"

LICENSE="GPL-3"
# Dependent crate licenses
LICENSE+=" Apache-2.0-with-LLVM-exceptions BSD MIT Unicode-3.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="delta-update"

RDEPEND="
	>=dev-python/python-xlib-0.33[${PYTHON_USEDEP}]
	>=dev-python/urllib3-2.0.0[${PYTHON_USEDEP}]
	delta-update? (
		>=dev-python/cbor2-5.4.6[${PYTHON_USEDEP}]
		>=dev-python/pyzstd-0.16.2[${PYTHON_USEDEP}]
		>=dev-python/xxhash-3.2.0[${PYTHON_USEDEP}]
	)
"
BDEPEND="
	app-text/scdoc
	delta-update? (
		${RUST_DEPEND}
	)
	test? (
		>=dev-python/cbor2-5.4.6[${PYTHON_USEDEP}]
		>=dev-python/pyzstd-0.16.2[${PYTHON_USEDEP}]
		>=dev-python/xxhash-3.2.0[${PYTHON_USEDEP}]
	)
"

PATCHES=(
	"${FILESDIR}/${P}-optional-delta.patch"
)

QA_FLAGS_IGNORED=".*/site-packages/umu/.*so"

EPYTEST_DESELECT=(
	# https://github.com/Open-Wine-Components/umu-launcher/blob/28eef5f5638d5660fb2d7c1811c8f2915a5e8c5b/packaging/nix/unwrapped.nix#L49
	umu/umu_test.py::TestGameLauncher::test_parse_args_noopts
)

distutils_enable_tests pytest

src_unpack() {
	if use delta-update; then
		cargo_src_unpack
	else
		default
	fi
}

src_configure() {
	distutils-r1_src_configure
	./configure.sh --prefix="${EPREFIX}"/usr || die
}

src_compile() {
	distutils-r1_src_compile
	emake umu-docs
	if use delta-update; then
		cargo_src_compile
		cp "$(cargo_target_dir)"/{libumu_delta.so,umu_delta.so} || die
	fi
}

python_test() {
	epytest -o 'python_files=test_*.py *_test_*.py *_test.py'
}

python_install() {
	distutils-r1_python_install
	if use delta-update; then
		python_moduleinto umu
		python_domodule "$(cargo_target_dir)"/umu_delta.so
	fi
}

src_install() {
	distutils-r1_src_install
	emake DESTDIR="${D}" umu-docs-install
}
