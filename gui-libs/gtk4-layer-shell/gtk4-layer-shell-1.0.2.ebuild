# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A library for using the Layer Shell Wayland protocol with GTK4."
HOMEPAGE="https://github.com/wmww/gtk4-layer-shell"
SRC_URI="https://github.com/wmww/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

IUSE="examples doc test smoke-tests introspection vala"
REQUIRED_USE="vala? ( introspection )"

RESTRICT="!test? ( test )"

PYTHON_COMPAT=( python3_{10..13} )
inherit meson python-any-r1

DEPEND="
	>=gui-libs/gtk-4.10.5[wayland]
"
RDEPEND="${DEPEND}"
BDEPEND="
	>=dev-build/meson-0.45.1
	>=dev-build/ninja-1.8.2
	introspection? ( dev-libs/gobject-introspection )
	doc? ( dev-util/gtk-doc )
	test? ( >=dev-lang/python-3.8.19 )
	vala? ( dev-lang/vala )
	smoke-tests? (
		dev-lang/luajit
		dev-lua/lgi
	)
"

src_configure() {
	local emesonargs=(
		$(meson_use examples)
		$(meson_use doc docs)
		$(meson_use test tests)
		$(meson_use smoke-tests)
		$(meson_use introspection)
		$(meson_use vala vapi)
	)
	meson_src_configure
}
