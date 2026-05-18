# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

RUST_MIN_VER="1.92"

inherit cargo gnome2-utils meson xdg

DESCRIPTION="Compare images and videos"
HOMEPAGE="
	https://apps.gnome.org/Identity/
	https://gitlab.gnome.org/YaLTeR/identity
"
SRC_URI="
	https://gitlab.gnome.org/YaLTeR/identity/-/archive/v${PV}/identity-v${PV}.tar.bz2 -> ${P}.tar.bz2
	https://gitlab.com/api/v4/projects/69517529/packages/generic/${PN}/${PV}/${P}-deps.tar.xz
"

S="${WORKDIR}/identity-v${PV}"

LICENSE="Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD GPL-3+ MIT MPL-2.0 Unicode-3.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-libs/glib:2
	gui-libs/gtk:4
	gui-libs/libadwaita:1
	media-libs/dav1d
	media-libs/glycin:2[gtk]
	media-libs/gst-plugins-base:1.0
	media-libs/gstreamer:1.0
	media-libs/libwebp
"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-libs/appstream
	dev-libs/glib:2
	dev-util/blueprint-compiler
	dev-util/desktop-file-utils
	dev-util/gtk-update-icon-cache
	sys-devel/gettext
"

src_configure() {
	meson_src_configure

	ln -s "${CARGO_HOME}" "${BUILD_DIR}/cargo-home" || die
}

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_schemas_update
}
