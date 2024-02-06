# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CRATES="
	atk-0.7.0
	atk-sys-0.9.1
	bitflags-1.2.1
	cairo-rs-0.7.1
	cairo-sys-rs-0.9.2
	cc-1.0.68
	clap-2.33.3
	dtoa-0.4.8
	fragile-0.3.0
	gdk-0.11.0
	gdk-pixbuf-0.7.0
	gdk-pixbuf-sys-0.9.1
	gdk-sys-0.9.1
	gio-0.7.0
	gio-sys-0.9.1
	glib-0.8.2
	glib-sys-0.9.1
	gobject-sys-0.9.1
	gtk-0.7.0
	gtk-sys-0.9.2
	lazy_static-1.4.0
	libc-0.2.97
	linked-hash-map-0.5.4
	maplit-1.0.2
	memmap-0.7.0
	pango-0.7.0
	pango-sys-0.9.1
	pkg-config-0.3.19
	proc-macro2-1.0.27
	quote-1.0.9
	regex-1.3.9
	regex-syntax-0.6.25
	serde-1.0.126
	serde_derive-1.0.126
	serde_yaml-0.8.17
	syn-1.0.73
	textwrap-0.11.0
	unicode-width-0.1.8
	unicode-xid-0.2.2
	winapi-0.3.9
	winapi-i686-pc-windows-gnu-0.4.0
	winapi-x86_64-pc-windows-gnu-0.4.0
	xkbcommon-0.4.0
	yaml-rust-0.4.5
"

inherit cargo gnome2-utils meson toolchain-funcs xdg

DESCRIPTION="Virtual keyboard supporting Wayland, built primarily for the Librem 5 phone"
HOMEPAGE="https://gitlab.gnome.org/World/Phosh/squeekboard"
SRC_URI="https://gitlab.gnome.org/World/Phosh/squeekboard/-/archive/v${PV}/squeekboard-v${PV}.tar.gz -> ${P}.tar.gz"
SRC_URI+=" $(cargo_crate_uris ${CRATES})"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

RDEPEND="
	${PYTHON_DEPS}
	dev-libs/feedbackd
	dev-libs/wayland
	dev-libs/wayland-protocols
	gnome-base/gnome-desktop
	media-fonts/noto-emoji
	x11-libs/gtk+:3[wayland]
"

BDEPEND="
	dev-util/gtk-doc
	dev-util/intltool
	virtual/pkgconfig
	virtual/rust
"

S="${WORKDIR}/${PN}-v${PV}"

QA_FLAGS_IGNORED="/usr/bin/squeekboard-test-layout"

src_install() {
	CC="$(tc-getCC)"
	meson_src_install
	insinto /usr/bin
	doins "${S}/tools/squeekboard-restyled"
}

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_schemas_update
}
