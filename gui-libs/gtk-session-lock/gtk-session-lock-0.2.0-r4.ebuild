# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )
VALA_USE_DEPEND="vapigen"
inherit vala meson python-any-r1

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Cu3PO42/${PN}.git"
else
	SRC_URI="https://github.com/Cu3PO42/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

DESCRIPTION="GTK-based lockscreen for Wayland"
HOMEPAGE="https://github.com/Cu3PO42/${PN}"

LICENSE="GPL-3"
SLOT="0"

IUSE="examples gtk-doc introspection test vala"
RESTRICT="!test? ( test )"

REQUIRED_USE="vala? ( introspection )"
DEPEND="
	x11-libs/gtk+:3[introspection?,wayland]
	>=dev-libs/wayland-1.22.0
	>=dev-libs/wayland-protocols-1.34
	test? ( gui-libs/gtk-layer-shell[introspection?] )
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
	test? ( ${PYTHON_DEPS} )
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
		$(meson_use test tests)
		$(meson_use introspection)
		$(meson_use vala vapi)
	)
	meson_src_configure
}
