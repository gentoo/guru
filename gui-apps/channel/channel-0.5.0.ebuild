# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
EAPI=8

DESCRIPTION="A flexible demon to provide live input configuration for river"
HOMEPAGE="https://codeberg.org/Sivecano/channel"

declare -g -r -A ZBS_DEPENDENCIES=(
	[tributary-0.4.1-tqCfWzbUAACWcbClrEM-xQIfPNogwri6nGNyWrt123vK.tar.gz]='https://codeberg.org/Sivecano/libtributary/archive/0.5.0.tar.gz'
	[wayland-0.6.0-lQa1kqz8AQADQmdNJsNhLoNHcnEGEUjrOaPV-dtEnEmX.tar.gz]='https://codeberg.org/ifreund/zig-wayland/archive/v0.6.0.tar.gz'
)

ZIG_SLOT="0.16"
inherit zig

SRC_URI="
	https://codeberg.org/Sivecano/channel/archive/${PV}.tar.gz -> ${P}.tar.gz
	${ZBS_DEPENDENCIES_SRC_URI}
"

S="${WORKDIR}/${PN}"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-libs/wayland
	x11-libs/libxkbcommon
"

BDEPEND="
	>=gui-wm/river-0.4.0
	dev-libs/wayland-protocols
"

RDEPEND="${DEPEND}"

src_configure() {
	local my_zbs_args=(
		-Dstrip=false # portage handles this
	)

	zig_src_configure
}
