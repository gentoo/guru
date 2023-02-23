# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
aho-corasick-0.7.18
assert_fs-1.0.7
autocfg-1.1.0
base64-0.13.0
bitflags-1.3.2
bstr-0.2.17
byteorder-1.4.3
cc-1.0.73
cfg-if-1.0.0
charset-0.1.3
chrono-0.4.19
chrono-tz-0.6.1
chrono-tz-build-0.0.2
clap-2.34.0
crossbeam-channel-0.5.4
crossbeam-utils-0.8.8
curl-0.4.43
curl-sys-0.4.53+curl-7.82.0
darling-0.10.2
darling_core-0.10.2
darling_macro-0.10.2
data-encoding-2.3.2
dbus-0.9.5
dbus-tree-0.9.2
difflib-0.4.0
dirs-next-2.0.0
dirs-sys-next-0.1.2
doc-comment-0.3.3
either-1.6.1
encoding_rs-0.8.31
fastrand-1.7.0
fnv-1.0.7
from_variants-0.6.0
from_variants_impl-0.6.0
gethostname-0.2.3
getrandom-0.2.6
globset-0.4.8
globwalk-0.8.1
ident_case-1.0.1
ignore-0.4.18
inotify-0.10.0
inotify-sys-0.1.5
instant-0.1.12
itertools-0.10.3
itoa-1.0.1
lazy_static-1.4.0
libc-0.2.123
libdbus-sys-0.2.2
libpulse-binding-2.26.0
libpulse-sys-1.19.3
libsensors-sys-0.2.0
libz-sys-1.1.5
log-0.4.16
maildir-0.6.1
mailparse-0.13.8
memchr-2.4.1
memoffset-0.6.5
neli-0.6.1
neli-proc-macros-0.1.1
neli-wifi-0.3.1
nix-0.23.1
notmuch-0.7.1
num-derive-0.3.3
num-integer-0.1.44
num-traits-0.2.14
once_cell-1.10.0
openssl-probe-0.1.5
openssl-sys-0.9.72
parse-zoneinfo-0.3.0
phf-0.10.1
phf_codegen-0.10.0
phf_generator-0.10.0
phf_shared-0.10.0
pkg-config-0.3.25
ppv-lite86-0.2.16
predicates-2.1.1
predicates-core-1.0.3
predicates-tree-1.0.5
proc-macro2-1.0.37
pure-rust-locales-0.5.6
quote-1.0.18
quoted_printable-0.4.5
rand-0.8.5
rand_chacha-0.3.1
rand_core-0.6.3
redox_syscall-0.2.13
redox_users-0.4.3
regex-1.5.5
regex-syntax-0.6.25
remove_dir_all-0.5.3
ryu-1.0.9
same-file-1.0.6
schannel-0.1.19
sensors-0.2.2
serde-1.0.136
serde_derive-1.0.136
serde_json-1.0.79
shellexpand-2.1.0
signal-hook-0.3.13
signal-hook-registry-1.4.0
siphasher-0.3.10
socket2-0.4.4
strsim-0.9.3
swayipc-3.0.0
swayipc-types-1.0.1
syn-1.0.91
tempfile-3.3.0
termtree-0.2.4
textwrap-0.11.0
thiserror-1.0.30
thiserror-impl-1.0.30
thread_local-1.1.4
time-0.1.43
toml-0.5.9
uncased-0.9.6
unicode-width-0.1.9
unicode-xid-0.2.2
vcpkg-0.2.15
version_check-0.9.4
walkdir-2.3.2
wasi-0.10.2+wasi-snapshot-preview1
winapi-0.3.9
winapi-i686-pc-windows-gnu-0.4.0
winapi-util-0.1.5
winapi-x86_64-pc-windows-gnu-0.4.0
"

inherit cargo

DESCRIPTION="A feature-rich and resource-friendly replacement for i3status, written in Rust."
HOMEPAGE="https://github.com/greshake/i3status-rust/"
SRC_URI="https://github.com/greshake/i3status-rust/archive/v${PV}.tar.gz -> ${P}.tar.gz
	$(cargo_crate_uris ${CRATES})"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

QA_FLAGS_IGNORED="usr/bin/i3status-rs"

DEPEND="sys-apps/dbus
	media-sound/pulseaudio"
RDEPEND="${DEPEND}"
BDEPEND=""

src_unpack() {
	cargo_src_unpack
	mv "${S}/man" "${S}/man.bak" || die
}

src_install() {
	doman "${S}/man.bak/i3status-rs.1"
	cargo_src_install
	insinto /usr/share/"${PN}"
	doins -r files/icons files/themes
}
