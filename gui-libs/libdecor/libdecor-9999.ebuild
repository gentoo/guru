# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="A client-side decorations library for Wayland clients"
HOMEPAGE="https://gitlab.freedesktop.org/libdecor/libdecor"
if [[ ${PV} == "9999" ]]; then
	EGIT_REPO_URI="https://gitlab.freedesktop.org/libdecor/libdecor.git"
	inherit git-r3
else
	SRC_URI="https://gitlab.freedesktop.org/libdecor/libdecor/-/archive/${PV}/${P}.tar.bz2"
	KEYWORDS="~amd64"
fi
LICENSE="MIT"
SLOT="0"
IUSE="+dbus +gtk examples"

DEPEND="
	>=dev-libs/wayland-1.18
	>=dev-libs/wayland-protocols-1.15
	x11-libs/pango
	x11-libs/cairo
	x11-libs/gtk+
	dbus? ( sys-apps/dbus )
	examples? (
		virtual/opengl
		media-libs/mesa[opengl(+)]
		x11-libs/libxkbcommon
	)
"
RDEPEND="${DEPEND}"

src_configure() {
	local emesonargs=(
		# Avoid auto-magic, built-in feature of meson
		-Dauto_features=disabled
		$(meson_feature gtk)
		$(meson_feature dbus)
		$(meson_use examples demo)
		-Dinstall_demo=true
	)

	meson_src_configure
}
