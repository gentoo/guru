# Copyright 2022-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit savedconfig meson

DESCRIPTION="dwm-like bar for dwl"
HOMEPAGE="https://git.sr.ht/~raphi/somebar"
SRC_URI="https://git.sr.ht/~raphi/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-libs/glib:2
	dev-libs/wayland
	x11-libs/cairo
	x11-libs/pango
"
DEPEND="
	${RDEPEND}
	dev-libs/wayland-protocols
"
BDEPEND="
	dev-util/wayland-scanner
"

src_prepare() {
	default
	use savedconfig && restore_config src/config.hpp
	[[ -f src/config.hpp ]] || cp src/config.def.hpp src/config.hpp
}

src_install() {
	meson_src_install
	save_config src/config.hpp
}
