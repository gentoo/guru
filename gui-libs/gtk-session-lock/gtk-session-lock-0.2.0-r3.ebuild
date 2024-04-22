# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="GTK-based lockscreen for Wayland"
HOMEPAGE="https://github.com/Cu3PO42/${PN}"
SRC_URI="https://github.com/Cu3PO42/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

IUSE="examples docs"
#RESTRICT="!test? ( test )"
RDEPEND="
	sys-libs/pam
	x11-libs/gtk+:3[wayland]
"
DEPEND="
	${DEPEND}
	>=dev-libs/wayland-protocols-1.34
	gui-libs/gtk-layer-shell
"
BDEPEND="
	dev-util/wayland-scanner
	virtual/pkgconfig
	dev-build/meson
"

src_configure() {
    local emesonargs=(
		$(meson_use examples examples)
		#$(meson_use test tests)
		$(meson_use docs docs)
		-Dintrospection=true
		-Dvapi=false
	)
    meson_src_configure
}
