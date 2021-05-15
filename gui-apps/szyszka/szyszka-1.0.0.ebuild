# Copyright 2017-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CRATES="
anyhow-1.0.40
atk-0.9.0
atk-sys-0.10.0
autocfg-1.0.1
bitflags-1.2.1
cairo-rs-0.9.1
cairo-sys-rs-0.10.0
cc-1.0.67
chrono-0.4.19
either-1.6.1
futures-0.3.15
futures-channel-0.3.15
futures-core-0.3.15
futures-executor-0.3.15
futures-io-0.3.15
futures-macro-0.3.15
futures-sink-0.3.15
futures-task-0.3.15
futures-util-0.3.15
gdk-0.13.2
gdk-pixbuf-0.9.0
gdk-pixbuf-sys-0.10.0
gdk-sys-0.10.0
gio-0.9.1
gio-sys-0.10.1
glib-0.10.3
glib-macros-0.10.1
glib-sys-0.10.1
gobject-sys-0.10.0
gtk-0.9.2
gtk-sys-0.10.0
heck-0.3.2
humansize-1.1.0
itertools-0.9.0
libc-0.2.94
memchr-2.4.0
num-integer-0.1.44
num-traits-0.2.14
once_cell-1.7.2
open-1.7.0
pango-0.9.1
pango-sys-0.10.0
pin-project-lite-0.2.6
pin-utils-0.1.0
pkg-config-0.3.19
proc-macro-crate-0.1.5
proc-macro-error-1.0.4
proc-macro-error-attr-1.0.4
proc-macro-hack-0.5.19
proc-macro-nested-0.1.7
proc-macro2-1.0.26
quote-1.0.9
serde-1.0.126
slab-0.4.3
strum-0.18.0
strum_macros-0.18.0
syn-1.0.72
system-deps-1.3.2
thiserror-1.0.24
thiserror-impl-1.0.24
time-0.1.44
toml-0.5.8
unicode-segmentation-1.7.1
unicode-xid-0.2.2
version-compare-0.0.10
version_check-0.9.3
wasi-0.10.0+wasi-snapshot-preview1
which-4.1.0
winapi-0.3.9
winapi-i686-pc-windows-gnu-0.4.0
winapi-x86_64-pc-windows-gnu-0.4.0
"

inherit cargo

DESCRIPTION="Simple, powerful and easy to use file renamer"
HOMEPAGE="https://github.com/qarmin/szyszka"
SRC_URI="https://www.github.com/qarmin/szyszka/archive/${PV}.tar.gz -> ${P}.tar.gz"
SRC_URI+=" $(cargo_crate_uris ${CRATES})"
RESTRICT="mirror"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
DEPEND=""
RDEPEND=">=x11-libs/gtk+-3"
QA_FLAGS_IGNORED="usr/bin/szyszka"
