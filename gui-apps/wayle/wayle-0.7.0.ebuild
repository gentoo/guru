# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cargo desktop shell-completion systemd xdg

RUST_MIN_VER="1.93.0"

DESCRIPTION="A configurable desktop shell for Wayland compositors"
HOMEPAGE="https://wayle.app"
SRC_URI="
	https://github.com/wayle-rs/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/gentoo-crate-dist/${PN}/releases/download/v${PV}/${P}-crates.tar.xz
"

LICENSE="MIT"
# Dependent crate licenses
LICENSE+="
	Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD-2 BSD CC0-1.0
	CDLA-Permissive-2.0 GPL-3+ ISC MIT openssl Unicode-3.0 ZLIB
"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+settings"

BDEPEND="virtual/pkgconfig"
DEPEND="
	dev-db/sqlite:3=
	dev-libs/glib
	dev-libs/wayland
	gui-libs/gtk:4=[wayland]
	gui-libs/gtk4-layer-shell
	media-libs/libpulse
	media-video/pipewire
	sci-libs/fftw
	virtual/libudev
	x11-libs/cairo
	x11-libs/gdk-pixbuf
	x11-libs/libxkbcommon
	x11-libs/pango
	settings? (
		gui-libs/gtksourceview:5
		media-libs/graphene
	)
"
RDEPEND="${DEPEND}"

src_configure() {
	# high magic to allow system-libs
	export LIBSQLITE3_SYS_USE_PKG_CONFIG=1
	export PKG_CONFIG_ALLOW_CROSS=1

	default
}

src_install() {
	cargo_src_install --path wayle
	use settings && cargo_src_install --path crates/wayle-settings

	local WAYLE_BIN="$(cargo_target_dir)/${PN}"

	mkdir completions || die
	for shell in bash fish zsh; do
		${WAYLE_BIN} completions ${shell} > "completions/${PN}.${shell}" || die
	done

	newbashcomp "completions/${PN}.bash" "${PN}"
	dofishcomp "completions/${PN}.fish"
	newzshcomp "completions/${PN}.zsh" "_${PN}"

	# Install module icons
	insinto /usr/share/icons/hicolor/scalable
	doins -r resources/icons/hicolor/scalable/actions/

	doicon -s scalable resources/wayle-settings.svg
	domenu resources/com.wayle.settings.desktop

	systemd_douserunit resources/wayle.service

	local DOCS=(
		README.md
	)
	local HTML_DOCS=(
		docs/
	)
	einstalldocs
}
