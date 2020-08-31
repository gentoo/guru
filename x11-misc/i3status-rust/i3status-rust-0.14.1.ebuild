# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CRATES="
addr2line-0.12.1
aho-corasick-0.7.10
assert_fs-1.0.0
autocfg-1.0.0
backtrace-0.3.48
base64-0.10.1
bitflags-1.2.1
bstr-0.2.13
byteorder-1.3.4
cc-1.0.54
cfg-if-0.1.10
charset-0.1.2
chrono-0.4.11
chrono-tz-0.5.1
clap-2.33.1
cpuprofiler-0.0.4
crossbeam-channel-0.4.2
crossbeam-utils-0.7.2
dbus-0.8.3
difference-2.0.0
doc-comment-0.3.3
encoding_rs-0.8.23
error-chain-0.12.2
failure-0.1.8
failure_derive-0.1.8
float-cmp-0.6.0
fnv-1.0.7
gethostname-0.2.1
getrandom-0.1.14
gimli-0.21.0
globset-0.4.5
globwalk-0.7.3
ignore-0.4.16
inotify-0.8.3
inotify-sys-0.1.3
itoa-0.4.5
lazy_static-1.4.0
libc-0.2.71
libdbus-sys-0.2.1
libpulse-binding-2.16.0
libpulse-sys-1.13.1
log-0.4.8
maildir-0.4.2
mailparse-0.12.1
maybe-uninit-2.0.0
memchr-2.3.3
nix-0.17.0
normalize-line-endings-0.3.0
notmuch-0.6.0
num-integer-0.1.42
num-traits-0.2.11
object-0.19.0
parse-zoneinfo-0.2.1
pkg-config-0.3.17
ppv-lite86-0.2.8
predicates-1.0.4
predicates-core-1.0.0
predicates-tree-1.0.0
proc-macro2-1.0.18
progress-0.2.0
quote-1.0.6
quoted_printable-0.4.2
rand-0.7.3
rand_chacha-0.2.2
rand_core-0.5.1
rand_hc-0.2.0
redox_syscall-0.1.56
regex-1.3.9
regex-syntax-0.6.18
remove_dir_all-0.5.2
rustc-demangle-0.1.16
ryu-1.0.5
same-file-1.0.6
serde-1.0.111
serde_derive-1.0.111
serde_json-1.0.53
supercow-0.1.0
swayipc-2.6.2
syn-1.0.30
synstructure-0.12.3
tempfile-3.1.0
terminal_size-0.1.12
textwrap-0.11.0
thread_local-1.0.1
time-0.1.43
toml-0.5.6
treeline-0.1.0
unicode-width-0.1.7
unicode-xid-0.2.0
uuid-0.8.1
version_check-0.9.2
void-1.0.2
walkdir-2.3.1
wasi-0.9.0+wasi-snapshot-preview1
winapi-0.3.8
winapi-i686-pc-windows-gnu-0.4.0
winapi-util-0.1.5
winapi-x86_64-pc-windows-gnu-0.4.0
"

inherit cargo eutils

DESCRIPTION="A feature-rich and resource-friendly replacement for i3status, written in Rust."
HOMEPAGE="https://github.com/greshake/i3status-rust/"
SRC_URI="https://github.com/greshake/i3status-rust/archive/v${PV}.tar.gz -> ${P}.tar.gz
	$(cargo_crate_uris ${CRATES})"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="profile"

DEPEND="sys-apps/dbus
	media-sound/pulseaudio
	profile? ( dev-util/google-perftools )"
RDEPEND="${DEPEND}"
BDEPEND=""

src_unpack() {
	cargo_src_unpack
	mv "${S}/man" "${S}/man.bak" || die
}

src_configure() {
	myfeatures=(
		$(usex profile profiling '')
	)
}

src_compile() {
	cargo_src_compile ${myfeatures:+--features "${myfeatures[*]}"}
}

src_install() {
	doman "${S}/man.bak/i3status-rs.1"
	cargo_src_install ${myfeatures:+--features "${myfeatures[*]}"}
}
