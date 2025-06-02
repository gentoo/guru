# Copyright 2023-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..14} )
RUST_MIN_VER="1.82.0"
inherit cargo flag-o-matic gnome2-utils meson python-any-r1 xdg

DESCRIPTION="Fast and secure file transfer"
HOMEPAGE="
	https://apps.gnome.org/Warp/
	https://gitlab.gnome.org/World/warp
"
SRC_URI="
	https://gitlab.gnome.org/World/warp/-/archive/v${PV}/${PN}-v${PV}.tar.bz2 -> ${P}.tar.bz2
	https://github.com/pastalian/distfiles/releases/download/${P}/${P}-crates.tar.xz
"
S="${WORKDIR}/${PN}-v${PV}"
ECARGO_HOME="${WORKDIR}/${P}-build/cargo-home"

LICENSE="GPL-3"
# Dependent crate licenses
LICENSE+="
	Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD EUPL-1.2 GPL-3+ MIT
	Unicode-3.0 Unlicense ZLIB
"
SLOT="0"
KEYWORDS="~amd64"
IUSE="qrcode"

DEPEND="
	>=dev-libs/glib-2.76:2
	>=gui-libs/gtk-4.14:4[wayland,X]
	>=gui-libs/libadwaita-1.7:1
	qrcode? (
		media-libs/graphene
		>=media-libs/gstreamer-1.18:1.0
		>=media-libs/gst-plugins-bad-1.18:1.0
		>=media-libs/gst-plugins-base-1.18:1.0[wayland]
		>=media-libs/gst-plugins-good-1.18:1.0
		>=media-plugins/gst-plugins-zbar-1.18:1.0
	)
"
RDEPEND="${DEPEND}"
BDEPEND="
	${PYTHON_DEPS}
	dev-util/itstool
"

QA_FLAGS_IGNORED="usr/bin/warp"

pkg_setup() {
	python-any-r1_pkg_setup
	rust_pkg_setup
}

src_prepare() {
	default
	python_fix_shebang build-aux/meson-cargo-manifest.py
}

src_configure() {
	filter-lto

	local emesonargs=(
		$(meson_feature qrcode qr-code-scanning)
	)
	meson_src_configure
}

pkg_postinst() {
	gnome2_schemas_update
	xdg_pkg_postinst
}

pkg_postrm() {
	gnome2_schemas_update
	xdg_pkg_postrm
}
