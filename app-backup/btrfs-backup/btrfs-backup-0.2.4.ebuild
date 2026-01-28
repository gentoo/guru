# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	aho-corasick@1.1.4
	anstream@0.6.21
	anstyle-parse@0.2.7
	anstyle-query@1.1.5
	anstyle-wincon@3.0.11
	anstyle@1.0.13
	anyhow@1.0.100
	bitflags@2.10.0
	btrfs-backup@0.2.4
	cfg-if@1.0.4
	clap@4.5.54
	clap_builder@4.5.54
	clap_complete@4.5.65
	clap_derive@4.5.49
	clap_lex@0.7.7
	colorchoice@1.0.4
	deranged@0.5.5
	errno@0.3.14
	fastrand@2.3.0
	futures-core@0.3.31
	futures-executor@0.3.31
	futures-task@0.3.31
	futures-util@0.3.31
	getrandom@0.3.4
	glob@0.3.3
	goblin@0.10.4
	grev@0.1.4
	heck@0.5.0
	is_terminal_polyfill@1.70.2
	itoa@1.0.17
	libc@0.2.180
	linux-raw-sys@0.11.0
	lock_api@0.4.14
	log@0.4.29
	memchr@2.7.6
	memmap@0.7.0
	num-conv@0.1.0
	num_threads@0.1.7
	once_cell@1.21.3
	once_cell_polyfill@1.70.2
	parking_lot@0.12.5
	parking_lot_core@0.9.12
	pin-project-lite@0.2.16
	pin-utils@0.1.0
	plain@0.2.3
	powerfmt@0.2.0
	proc-macro2@1.0.105
	quote@1.0.43
	r-efi@5.3.0
	redox_syscall@0.5.18
	regex-automata@0.4.13
	regex-syntax@0.8.8
	regex@1.12.2
	rustix@1.1.3
	scc@2.4.0
	scopeguard@1.2.0
	scroll@0.13.0
	scroll_derive@0.13.1
	sdd@3.0.10
	serde_core@1.0.228
	serde_derive@1.0.228
	serial_test@3.3.1
	serial_test_derive@3.3.1
	slab@0.4.11
	smallvec@1.15.1
	strsim@0.11.1
	syn@2.0.114
	tempfile@3.24.0
	time-core@0.1.7
	time-macros@0.2.25
	time@0.3.45
	uname@0.1.1
	unicode-ident@1.0.22
	utf8parse@0.2.2
	wasip2@1.0.2+wasi-0.2.9
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-x86_64-pc-windows-gnu@0.4.0
	winapi@0.3.9
	windows-link@0.2.1
	windows-sys@0.61.2
	wit-bindgen@0.51.0
"

inherit cargo shell-completion

DESCRIPTION="A program for backup & restoration of btrfs subvolumes"
HOMEPAGE="https://github.com/d-e-s-o/btrfs-backup"
SRC_URI="
	${CARGO_CRATE_URIS}
"

LICENSE="GPL-3+"
# Dependent crate licenses
LICENSE+=" Apache-2.0 MIT Unicode-3.0"
SLOT="0"
KEYWORDS="~amd64"
# Tests require and assume sudo.
RESTRICT="test"

RDEPEND="
	sys-fs/btrfs-progs
"
DEPEND="${RDEPEND}"

src_compile() {
	cargo_src_compile --bin="${PN}"
	# Install shell-complete binary into target directory to be able to
	# use it later on.
	cargo install --bin=shell-complete --features=clap_complete --path . --root "$(cargo_target_dir)" || die
}

src_install() {
	cargo_src_install --bin="${PN}"

	"$(cargo_target_dir)"/bin/shell-complete bash > "${PN}.bash" || die
	dobashcomp "${PN}.bash"

	"$(cargo_target_dir)"/bin/shell-complete fish >> "${PN}.fish" || die
	dofishcomp "${PN}.fish"

	einstalldocs
}
