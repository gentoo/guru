# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

is_live() {
	[[ ${PV} == 9999 ]]
}

CRATES="
	aho-corasick@0.7.20
	android_system_properties@0.1.5
	autocfg@1.1.0
	bit_field@0.10.1
	bitflags@1.3.2
	built@0.5.2
	bumpalo@3.12.1
	cargo-lock@8.0.3
	cc@1.0.79
	cfg-if@1.0.0
	chrono@0.4.24
	clap@4.0.32
	clap-verbosity-flag@2.0.1
	clap_derive@4.0.21
	clap_lex@0.3.0
	codespan-reporting@0.11.1
	convert_case@0.4.0
	core-foundation@0.6.4
	core-foundation-sys@0.6.2
	core-foundation-sys@0.8.4
	cxx@1.0.94
	cxx-build@1.0.94
	cxxbridge-flags@1.0.94
	cxxbridge-macro@1.0.94
	derive_more@0.99.17
	env_logger@0.10.0
	errno@0.2.8
	errno-dragonfly@0.1.2
	form_urlencoded@1.1.0
	getopts@0.2.21
	git2@0.15.0
	heck@0.4.0
	hermit-abi@0.2.6
	hidapi@2.1.0
	humantime@2.1.0
	iana-time-zone@0.1.56
	iana-time-zone-haiku@0.1.1
	idna@0.3.0
	io-kit-sys@0.1.0
	io-lifetimes@1.0.3
	is-terminal@0.4.2
	itoa@1.0.5
	jobserver@0.1.26
	js-sys@0.3.61
	lazy_static@1.4.0
	libc@0.2.139
	libgit2-sys@0.14.2+1.5.1
	libusb1-sys@0.6.4
	libz-sys@1.1.9
	link-cplusplus@1.0.8
	linux-raw-sys@0.1.4
	lock_api@0.4.9
	log@0.4.17
	mach@0.2.3
	mach@0.3.2
	memchr@2.5.0
	memoffset@0.6.5
	nix@0.25.1
	no-std-compat@0.4.1
	num@0.4.0
	num-complex@0.4.2
	num-derive@0.3.3
	num-integer@0.1.45
	num-iter@0.1.43
	num-rational@0.4.1
	num-traits@0.2.15
	once_cell@1.16.0
	os_str_bytes@6.4.1
	percent-encoding@2.2.0
	pin-utils@0.1.0
	pkg-config@0.3.26
	plain@0.2.3
	proc-macro-error@1.0.4
	proc-macro-error-attr@1.0.4
	proc-macro2@1.0.56
	ptr_meta@0.2.0
	ptr_meta_derive@0.2.0
	quote@1.0.26
	redox_hwio@0.1.6
	regex@1.7.0
	regex-syntax@0.6.28
	rusb@0.9.1
	rustc_version@0.4.0
	rustix@0.36.5
	ryu@1.0.12
	scopeguard@1.1.0
	scratch@1.0.5
	semver@1.0.17
	serde@1.0.151
	serde_derive@1.0.151
	serde_json@1.0.91
	spin@0.5.2
	spin@0.9.4
	strsim@0.10.0
	syn@1.0.107
	syn@2.0.13
	termcolor@1.1.3
	tinyvec@1.6.0
	tinyvec_macros@0.1.1
	toml@0.5.11
	ucs2@0.3.2
	uefi-macros@0.11.0
	unicode-bidi@0.3.13
	unicode-ident@1.0.6
	unicode-normalization@0.1.22
	unicode-width@0.1.10
	url@2.3.1
	vcpkg@0.2.15
	version_check@0.9.4
	wasm-bindgen@0.2.84
	wasm-bindgen-backend@0.2.84
	wasm-bindgen-macro@0.2.84
	wasm-bindgen-macro-support@0.2.84
	wasm-bindgen-shared@0.2.84
	winapi@0.3.9
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-util@0.1.5
	winapi-x86_64-pc-windows-gnu@0.4.0
	windows@0.42.0
	windows@0.48.0
	windows-sys@0.42.0
	windows-targets@0.48.0
	windows_aarch64_gnullvm@0.42.0
	windows_aarch64_gnullvm@0.48.0
	windows_aarch64_msvc@0.42.0
	windows_aarch64_msvc@0.48.0
	windows_i686_gnu@0.42.0
	windows_i686_gnu@0.48.0
	windows_i686_msvc@0.42.0
	windows_i686_msvc@0.48.0
	windows_x86_64_gnu@0.42.0
	windows_x86_64_gnu@0.48.0
	windows_x86_64_gnullvm@0.42.0
	windows_x86_64_gnullvm@0.48.0
	windows_x86_64_msvc@0.42.0
	windows_x86_64_msvc@0.48.0
"

if ! is_live; then
	GIT_COMMIT_UEFI_RS="76130a0f1c1585012e598b8c514526bac09c68e0"
	GIT_COMMIT_SMBIOS_LIB="b3e2fff8a6f4b8c2d729467cbbf0c8c41974cd1c"

	declare -A GIT_CRATES=(
		[uefi]="https://github.com/FrameworkComputer/uefi-rs;${GIT_COMMIT_UEFI_RS};uefi-rs-%commit%/uefi"
		[uefi-services]="https://github.com/FrameworkComputer/uefi-rs;${GIT_COMMIT_UEFI_RS};uefi-rs-%commit%/uefi-services"
		[smbios-lib]="https://github.com/FrameworkComputer/smbios-lib;${GIT_COMMIT_SMBIOS_LIB}"
	)
fi

inherit cargo

MY_PN="framework-system"

if is_live; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/FrameworkComputer/framework-system.git"
else
	if [[ ${PV} == *_pre* || ${PV} == *_p* ]]; then
		GIT_COMMIT="053d6ef283192d4ed3100fc3bc1936f5e9944ea2"
		[[ -n ${GIT_COMMIT} ]] ||
			die "GIT_COMMIT is not defined for snapshot ebuild"
		MY_PV="${GIT_COMMIT}"
		MY_P="${MY_PN}-${MY_PV}"
	else
		MY_PV="v${PV}"
		MY_P="${MY_PN}-${PV}"
	fi

	SRC_URI="
		https://github.com/FrameworkComputer/framework-system/archive/${MY_PV}.tar.gz -> ${MY_PN}-${PV}.tar.gz
		${CARGO_CRATE_URIS}
	"
	S="${WORKDIR}/${MY_P}"

	KEYWORDS="~amd64"
fi

DESCRIPTION="Tool to interact with a Framework Laptop's hardware system"
HOMEPAGE="https://github.com/FrameworkComputer/framework-system"

LICENSE="BSD"
# Crate licenses
LICENSE+=" Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD-2 Boost-1.0 MIT MPL-2.0 Unicode-DFS-2016 Unlicense ZLIB"

SLOT="0"

RDEPEND="
	virtual/libudev:=
	virtual/libusb:1
"

DEPEND="
	${RDEPEND}
"

DOCS=( README.md support-matrices.md )

# Usual setting for a Rust package
QA_FLAGS_IGNORED="usr/bin/framework_tool"

src_unpack() {
	if is_live; then
		git-r3_src_unpack
		cargo_live_src_unpack
	else
		cargo_src_unpack
	fi
}

src_prepare() {
	default

	# Upstream uses [patch] on some dependencies in Cargo.toml,
	# which are not patched by cargo.eclass's ${ECARGO_HOME}/config
	local crate commit crate_uri crate_dir
	local -a sed_scripts
	for crate in "${!GIT_CRATES[@]}"; do
		IFS=';' read -r \
			crate_uri commit crate_dir <<< "${GIT_CRATES[${crate}]}"
		# Taken from dev-util/difftastic::gentoo ebuilds
		sed_scripts+=(
			"s|^(${crate}[[:space:]]*=[[:space:]]*[{].*)([[:space:]]*git[[:space:]]*=[[:space:]]*['\"][[:graph:]]+['\"][[:space:]]*)(.*[}])|\1path = '${WORKDIR}/${crate_dir//%commit%/${commit}}'\3|;"
			"s|^(${crate}[[:space:]]*=[[:space:]]*[{].*)([,][[:space:]]*branch[[:space:]]*=[[:space:]]*['\"][[:graph:]]+['\"][[:space:]]*)(.*[}])|\1\3|;"
		)
	done
	sed -i -E -e "${sed_scripts[*]}" Cargo.toml ||
		die "Failed to override dependencies in Cargo.toml"
}

src_install() {
	dobin target/release/framework_tool
	einstalldocs
}

pkg_postinst() {
	[[ -n ${REPLACING_VERSIONS} ]] && return
	elog "Framework Laptop 13 Ryzen 7040 Series users might need to"
	elog "follow these steps to use most features of framework_tool:"
	elog
	elog "1. Disable kernel_lockdown(7)"
	elog "2. Run 'framework_tool' with option '--driver portio'"
	elog
	elog "For more information, please consult:"
	elog "  https://github.com/FrameworkComputer/framework-system/issues/20"
}
