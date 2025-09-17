# Copyright 2023-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
addr2line@0.24.2
adler2@2.0.0
aho-corasick@1.1.3
allocator-api2@0.2.21
android_system_properties@0.1.5
android-tzdata@0.1.1
anstream@0.6.18
anstyle@1.0.10
anstyle-parse@0.2.6
anstyle-query@1.1.2
anstyle-wincon@3.0.6
async-trait@0.1.83
autocfg@1.4.0
backtrace@0.3.74
bitflags@2.6.0
bumpalo@3.16.0
bytes@1.9.0
cairo-rs@0.20.7
cairo-sys-rs@0.20.7
cc@1.2.6
cfg-expr@0.17.2
cfg-if@1.0.0
chrono@0.4.39
clap@4.5.23
clap_builder@4.5.23
clap_derive@4.5.18
clap_lex@0.7.4
colorchoice@1.0.3
const_format@0.2.34
const_format_proc_macros@0.2.34
core-foundation-sys@0.8.7
crc32fast@1.4.2
crossbeam-channel@0.5.15
crossbeam-utils@0.8.21
deranged@0.3.11
educe@0.6.0
enum-ordinalize@4.3.0
enum-ordinalize-derive@4.3.1
equivalent@1.0.1
field-offset@0.3.6
file-rotate@0.7.6
flate2@1.0.35
flume@0.11.1
foldhash@0.1.4
fragile@2.0.0
futures@0.3.31
futures-channel@0.3.31
futures-core@0.3.31
futures-executor@0.3.31
futures-io@0.3.31
futures-macro@0.3.31
futures-sink@0.3.31
futures-task@0.3.31
futures-util@0.3.31
gdk4@0.9.5
gdk4-sys@0.9.5
gdk-pixbuf@0.20.7
gdk-pixbuf-sys@0.20.7
getrandom@0.2.15
gimli@0.31.1
gio@0.20.7
gio-sys@0.20.8
glib@0.20.7
glib-macros@0.20.7
glib-sys@0.20.7
glob@0.3.2
gobject-sys@0.20.7
graphene-rs@0.20.7
graphene-sys@0.20.7
greetd_ipc@0.10.3
gsk4@0.9.5
gsk4-sys@0.9.5
gtk4@0.9.5
gtk4-macros@0.9.5
gtk4-sys@0.9.5
hashbrown@0.15.2
heck@0.5.0
humantime@2.1.0
humantime-serde@1.1.1
iana-time-zone@0.1.61
iana-time-zone-haiku@0.1.2
indexmap@2.7.0
is_terminal_polyfill@1.70.1
itoa@1.0.14
jiff@0.1.16
jiff-tzdb@0.1.1
jiff-tzdb-platform@0.1.1
js-sys@0.3.76
konst@0.2.19
konst_macro_rules@0.2.19
lazy_static@1.5.0
libc@0.2.169
lock_api@0.4.12
log@0.4.22
lru@0.12.5
memchr@2.7.4
memoffset@0.9.1
miniz_oxide@0.8.2
mio@1.0.3
nanorand@0.7.0
nu-ansi-term@0.50.1
num-conv@0.1.0
num_threads@0.1.7
num-traits@0.2.19
object@0.36.7
once_cell@1.20.2
pango@0.20.7
pango-sys@0.20.7
pin-project-lite@0.2.15
pin-utils@0.1.0
pkg-config@0.3.31
powerfmt@0.2.0
proc-macro2@1.0.92
proc-macro-crate@3.2.0
pwd@1.4.0
quote@1.0.38
regex@1.11.1
regex-automata@0.4.9
regex-syntax@0.8.5
relm4@0.9.1
relm4-css@0.9.0
relm4-macros@0.9.1
rustc-demangle@0.1.24
rustc_version@0.4.1
ryu@1.0.18
scopeguard@1.2.0
semver@1.0.24
serde@1.0.217
serde_derive@1.0.217
serde_json@1.0.134
serde_spanned@0.6.8
sharded-slab@0.1.7
shlex@1.3.0
slab@0.4.9
smallvec@1.13.2
socket2@0.5.8
spin@0.9.8
strsim@0.11.1
syn@2.0.93
system-deps@7.0.3
target-lexicon@0.12.16
test-case@3.3.1
test-case-core@3.3.1
test-case-macros@3.3.1
thiserror@1.0.69
thiserror@2.0.9
thiserror-impl@1.0.69
thiserror-impl@2.0.9
thread_local@1.1.8
time@0.3.37
time-core@0.1.2
time-macros@0.2.19
tokio@1.43.1
toml@0.8.19
toml_datetime@0.6.8
toml_edit@0.22.22
tracing@0.1.41
tracing-appender@0.2.3
tracing-attributes@0.1.28
tracing-core@0.1.33
tracing-log@0.2.0
tracing-subscriber@0.3.20
tracker@0.2.2
tracker-macros@0.2.2
unicode-ident@1.0.14
unicode-xid@0.2.6
utf8parse@0.2.2
valuable@0.1.0
version-compare@0.2.0
wasi@0.11.0+wasi-snapshot-preview1
wasm-bindgen@0.2.99
wasm-bindgen-backend@0.2.99
wasm-bindgen-macro@0.2.99
wasm-bindgen-macro-support@0.2.99
wasm-bindgen-shared@0.2.99
windows_aarch64_gnullvm@0.52.6
windows_aarch64_msvc@0.52.6
windows-core@0.52.0
windows_i686_gnu@0.52.6
windows_i686_gnullvm@0.52.6
windows_i686_msvc@0.52.6
windows-sys@0.52.0
windows-sys@0.59.0
windows-targets@0.52.6
windows_x86_64_gnu@0.52.6
windows_x86_64_gnullvm@0.52.6
windows_x86_64_msvc@0.52.6
winnow@0.6.20
"

inherit cargo readme.gentoo-r1 tmpfiles
DESCRIPTION="A clean and customizable GTK-based greetd greeter written in Rust"
HOMEPAGE="https://github.com/rharish101/ReGreet"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/rharish101/${PN}.git"
else
	SRC_URI="
		https://github.com/rharish101/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz
		${CARGO_CRATE_URIS}
	"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3"
SLOT="0"

RDEPEND="
	systemd? ( sys-apps/systemd[sysv-utils] )
	openrc? ( sys-apps/openrc[sysv-utils] )
	gui-libs/gtk
	gui-libs/greetd
	dev-libs/glib
	media-libs/graphene
	x11-libs/cairo
	x11-libs/gdk-pixbuf
	x11-libs/pango
"
IUSE="systemd openrc"

PATCHES="${FILESDIR}/${PN}-${PV}-cargo-toml-fix.diff"

QA_FLAGS_IGNORED="/usr/bin/regreet"

src_unpack() {
	if [[ ${PV} == 9999 ]]; then
		git-r3_src_unpack
		cargo_live_src_unpack
	else
		unpack "${P}.tar.gz"
		cargo_src_unpack
	fi
}

src_configure() {
	local myfeatures=(
		gtk4_8
	)

	cargo_src_configure
}

src_prepare() {
	default

	if use systemd; then
		sed -i 's/greeter/greetd/g' "${S}/systemd-tmpfiles.conf" || die
	fi
}

src_compile() {
	cargo_gen_config

	# Export default configuration
	export RUSTUP_TOOLCHAIN=stable
	export GREETD_CONFIG_DIR="/etc/greetd"
	export STATE_DIR="/var/lib/regreet"
	export LOG_DIR="/var/log/regreet"
	export SESSION_DIRS="/usr/share/xsessions:/usr/share/wayland-sessions"
	# Require sysv-utils useflag enable on the init system
	export REBOOT_CMD="reboot"
	export POWEROFF_CMD="poweroff"

	cargo_src_compile
}

src_install() {
	cargo_src_install

	if use systemd; then
		newtmpfiles "${S}/systemd-tmpfiles.conf" regreet.conf
	elif use openrc; then
		keepdir /var/log/regreet
		fowners greetd:greetd /var/log/regreet
		fperms 0755 /var/log/regreet

		keepdir /var/lib/regreet
		fowners greetd:greetd /var/lib/regreet
		fperms 0755 /var/lib/regreet
	fi
	# Install ReGreet template config file as a doc
	dodoc "${S}/regreet.sample.toml"

	# Create README.gentoo doc file
	readme.gentoo_create_doc

	elog "ReGreet sample config file available on: /usr/share/doc/${P}/regreet.sample.toml.bz2"
	elog "To use decompress it to /etc/greetd/regreet.toml"

}

src_post_install() {
	if use systemd; then
		# Run systemd-tmpfiles to create the log and cache folder
		tmpfiles_process regreet.conf
	fi

	# Print README.gentoo file in the elog
	readme.gentoo_print_elog
}
