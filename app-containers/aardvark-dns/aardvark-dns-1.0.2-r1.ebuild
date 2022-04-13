# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
aho-corasick-0.7.18
anyhow-1.0.56
async-broadcast-0.4.0
async-trait-0.1.52
atty-0.2.14
autocfg-1.1.0
bitflags-1.3.2
bytes-1.1.0
cfg-if-1.0.0
chrono-0.4.19
clap-3.1.6
clap_derive-3.1.4
data-encoding-2.3.2
easy-parallel-3.2.0
endian-type-0.1.2
enum-as-inner-0.3.3
enum-as-inner-0.4.0
env_logger-0.9.0
error-chain-0.12.4
event-listener-2.5.2
form_urlencoded-1.0.1
futures-channel-0.3.21
futures-core-0.3.21
futures-executor-0.3.21
futures-io-0.3.21
futures-macro-0.3.21
futures-task-0.3.21
futures-util-0.3.21
getrandom-0.2.5
hashbrown-0.11.2
heck-0.3.3
heck-0.4.0
hermit-abi-0.1.19
hostname-0.3.1
humantime-2.1.0
idna-0.2.3
indexmap-1.8.0
instant-0.1.12
ipnet-2.3.1
itoa-1.0.1
lazy_static-1.4.0
libc-0.2.119
lock_api-0.4.6
log-0.4.16
match_cfg-0.1.0
matches-0.1.9
memchr-2.4.1
mio-0.8.0
miow-0.3.7
nibble_vec-0.1.0
ntapi-0.3.7
num-integer-0.1.44
num-traits-0.2.14
num_cpus-1.13.1
num_threads-0.1.3
once_cell-1.9.0
os_str_bytes-6.0.0
parking_lot-0.11.2
parking_lot-0.12.0
parking_lot_core-0.8.5
parking_lot_core-0.9.1
percent-encoding-2.1.0
pin-project-lite-0.2.8
pin-utils-0.1.0
ppv-lite86-0.2.16
proc-macro-error-1.0.4
proc-macro-error-attr-1.0.4
proc-macro2-1.0.36
quick-error-1.2.3
quote-1.0.15
radix_trie-0.2.1
rand-0.8.5
rand_chacha-0.3.1
rand_core-0.6.3
redox_syscall-0.2.10
regex-1.5.4
regex-syntax-0.6.25
resolv-conf-0.7.0
scopeguard-1.1.0
serde-1.0.136
serde_derive-1.0.136
signal-hook-0.3.13
signal-hook-registry-1.4.0
slab-0.4.5
smallvec-1.8.0
socket2-0.4.4
strsim-0.10.0
syn-1.0.86
syslog-6.0.1
termcolor-1.1.2
textwrap-0.15.0
thiserror-1.0.30
thiserror-impl-1.0.30
time-0.1.43
time-0.3.7
tinyvec-1.5.1
tinyvec_macros-0.1.0
tokio-1.17.0
tokio-macros-1.7.0
toml-0.5.8
trust-dns-client-0.20.4
trust-dns-client-0.21.1
trust-dns-proto-0.20.4
trust-dns-proto-0.21.1
trust-dns-server-0.21.1
unicode-bidi-0.3.7
unicode-normalization-0.1.19
unicode-segmentation-1.9.0
unicode-xid-0.2.2
url-2.2.2
version_check-0.9.4
wasi-0.10.2+wasi-snapshot-preview1
winapi-0.3.9
winapi-i686-pc-windows-gnu-0.4.0
winapi-util-0.1.5
winapi-x86_64-pc-windows-gnu-0.4.0
windows-sys-0.32.0
windows_aarch64_msvc-0.32.0
windows_i686_gnu-0.32.0
windows_i686_msvc-0.32.0
windows_x86_64_gnu-0.32.0
windows_x86_64_msvc-0.32.0
"

inherit cargo

DESCRIPTION="A container-focused DNS server"
HOMEPAGE="https://github.com/containers/aardvark-dns"
SRC_URI="$(cargo_crate_uris) https://github.com/containers/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
RESTRICT="mirror"
LICENSE="Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD-2 BSD MIT BSL-1.1 Unlicense ZLIB"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND=""

QA_FLAGS_IGNORED="usr/libexec/podman/${PN}"

src_install() {
	exeinto /usr/libexec/podman
	doexe target/release/${PN}
}
