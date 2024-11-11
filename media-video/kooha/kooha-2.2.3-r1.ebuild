# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cargo meson xdg gnome2-utils

DESCRIPTION="GTK4 screen recorder for Wayland"
HOMEPAGE="https://github.com/SeaDve/Kooha/"
SRC_URI="https://github.com/SeaDve/Kooha/releases/download/v${PV}/kooha-${PV}.tar.xz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

IUSE="x264 vaapi test"
RESTRICT="!test? ( test )"

DEPEND="
		x264? ( >=media-libs/x264-0.0.20220222
				>=media-libs/gst-plugins-ugly-1.20.6 )
		>=media-libs/gstreamer-1.20.6
		>=media-libs/gst-plugins-base-1.20.6
		vaapi? ( >=media-plugins/gst-plugins-vaapi-1.20.6 )
		>=dev-libs/glib-2.76.3
		>=gui-libs/gtk-4.10.4
		>=gui-libs/libadwaita-1.3.3
		>=media-libs/libpulse-15.0[glib]
		>=media-video/pipewire-0.3.77-r1[gstreamer]
		>=sys-apps/xdg-desktop-portal-1.16.0-r1
"
RDEPEND="${DEPEND}"
BDEPEND="
		app-alternatives/ninja
		>=dev-build/meson-1.1.1
		>=dev-libs/appstream-glib-0.8.2
		test? ( || ( dev-lang/rust[clippy]
					 dev-lang/rust-bin[clippy] ) )
"

# rust does not use *FLAGS from make.conf, silence portage warning
# update with proper path to binaries this crate installs, omit leading /
QA_FLAGS_IGNORED="usr/bin/${PN}"

BUILD_DIR="${S}/build"

src_prepare() {
	default

	sed -i \
		-e '/^gnome.post_install(/,/)/d' \
		meson.build \
		|| die
}

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_schemas_update
}
