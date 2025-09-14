# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cargo gnome2-utils meson xdg

DESCRIPTION="2FA code generator for GNOME"
HOMEPAGE="https://gitlab.gnome.org/World/Authenticator"
SRC_URI="
	https://gitlab.gnome.org/World/Authenticator/-/archive/${PV}/Authenticator-${PV}.tar.bz2 -> ${P}.tar.bz2
	https://gitlab.com/api/v4/projects/69517529/packages/generic/${PN}/${PV}/${P}-deps.tar.xz
"

S="${WORKDIR}/Authenticator-${PV}"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"
IUSE="debug test"
RESTRICT="!test? ( test )"

RDEPEND="
	dev-libs/glib:2
	gui-libs/gtk:4
	gui-libs/libadwaita:1
	media-libs/gst-plugins-base:1.0
	media-libs/gstreamer:1.0
	media-plugins/gst-plugin-gtk4
"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-libs/appstream
	dev-libs/glib:2
	dev-util/desktop-file-utils
	dev-util/gtk-update-icon-cache
	sys-devel/gettext

	debug? ( dev-vcs/git )
"

src_configure() {
	local profile="default"
	use debug && profile="development"

	local emesonargs=(
		-Dprofile="$profile"
	)
	meson_src_configure

	ln -s "${CARGO_HOME}" "${BUILD_DIR}/cargo-home" || die
}

src_test() {
	cargo_src_test
	meson_src_test
}

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_schemas_update
}
