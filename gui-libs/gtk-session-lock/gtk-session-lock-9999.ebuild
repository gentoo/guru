# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

VALA_USE_DEPEND="vapigen"
inherit vala meson

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Cu3PO42/${PN}.git"
else
	SRC_URI="https://github.com/Cu3PO42/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

DESCRIPTION="GTK-based lockscreen for Wayland"
HOMEPAGE="https://github.com/Cu3PO42/gtk-session-lock"

LICENSE="GPL-3"
SLOT="0"

IUSE="examples gtk-doc introspection vala"
# https://github.com/Cu3PO42/gtk-session-lock/commit/a92080b164df7553aa250d43f90965535a3050ba
RESTRICT="test"

REQUIRED_USE="vala? ( introspection )"
DEPEND="
	dev-libs/glib
	x11-libs/gtk+:3[introspection?,wayland]
	>=dev-libs/wayland-1.22.0
	>=dev-libs/wayland-protocols-1.34
	gui-libs/gtk-layer-shell
"
RDEPEND="
	${DEPEND}
	sys-libs/pam
"
BDEPEND="
	dev-util/wayland-scanner
	virtual/pkgconfig
	dev-build/meson
	gtk-doc? ( dev-util/gtk-doc )
	vala? ( $(vala_depend) )
"

src_prepare() {
	default
	use vala && vala_setup
}

src_configure() {
	local emesonargs=(
		$(meson_use examples)
		$(meson_use gtk-doc docs)
		-Dtests=false
		$(meson_use introspection)
		$(meson_use vala vapi)
	)
	meson_src_configure
}
