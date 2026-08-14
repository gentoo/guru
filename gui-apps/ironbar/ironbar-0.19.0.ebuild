# Copyright 2024-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cargo

RUST_MIN_VER="1.88.0"

DESCRIPTION="Customisable Wayland gtk bar written in Rust"
HOMEPAGE="https://crates.io/crates/ironbar"
SRC_URI="https://github.com/JakeStanger/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
SRC_URI+=" https://github.com/gentoo-crate-dist/${PN}/releases/download/v${PV}/${P}-crates.tar.xz"

LICENSE="MIT"
# Dependent crate licenses
LICENSE+="
	Apache-2.0 BSD CC0-1.0 GPL-3+ ISC MIT MPL-2.0 Unicode-DFS-2016
"
SLOT="0"
KEYWORDS="~amd64"
IUSE="cairo +http +keyboard +music notifications +tray +volume"

DEPEND="
	gui-libs/gtk[wayland]
	gui-libs/gtk4-layer-shell[introspection]
	cairo? ( dev-lua/lgi[lua_targets_luajit] )
	keyboard? ( dev-libs/libinput )
	music? ( sys-apps/dbus )
	notifications? ( gui-apps/swaync )
	volume? ( media-libs/libpulse )
"
RDEPEND="
	${DEPEND}
	dev-libs/glib
	dev-libs/libevdev
	x11-libs/cairo
	x11-libs/gdk-pixbuf
	x11-libs/pango
"
BDEPEND="
	virtual/pkgconfig
"

QA_FLAGS_IGNORED="usr/bin/${PN}"

src_configure() {
	# high magic to allow system-libs
	export PKG_CONFIG_ALLOW_CROSS=1

	local myfeatures=(
		"battery"
		"bindmode+all"
		"bluetooth"
		"brightness"
		"cli"
		$(usev cairo)
		"clipboard"
		"clock"
		"config+all"
		"custom"
		"extras"
		"focused"
		"http"
		"ipc"
		$(usex "keyboard" "keyboard+all" "")
		"label"
		"launcher"
		"menu"
		$(usex "music" "music+all" "")
		"network_manager"
		$(usev notifications)
		"script"
		"sys_info"
		$(usev tray)
		$(usev volume)
		"workspaces+all"
	)
	cargo_src_configure --no-default-features
}

src_install() {
	cargo_src_install

	local DOCS=(
		CHANGELOG.md
		CONTRIBUTING.md
		README.md
		examples/
	)
	local HTML_DOCS=(
		docs/
	)
	docompress -x /usr/share/doc/${PF}/examples
	einstalldocs
}
