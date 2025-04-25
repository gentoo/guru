# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A dynamic tiling Wayland compositor"
HOMEPAGE="https://isaacfreund.com/software/river/ https://codeberg.org/river/river"

declare -g -r -A ZBS_DEPENDENCIES=(
	[pixman-0.3.0-LClMnz2VAAAs7QSCGwLimV5VUYx0JFnX5xWU6HwtMuDX.tar.gz]='https://codeberg.org/ifreund/zig-pixman/archive/v0.3.0.tar.gz'
	[wayland-0.3.0-lQa1kjPIAQDmhGYpY-zxiRzQJFHQ2VqhJkQLbKKdt5wl.tar.gz]='https://codeberg.org/ifreund/zig-wayland/archive/v0.3.0.tar.gz'
	[wlroots-0.18.2-jmOlchnIAwBq45_cxU1V3OWErxxJjQZlc9PyJfR-l3uk.tar.gz]='https://codeberg.org/ifreund/zig-wlroots/archive/v0.18.2.tar.gz'
	[xkbcommon-0.3.0-VDqIe3K9AQB2fG5ZeRcMC9i7kfrp5m2rWgLrmdNn9azr.tar.gz]='https://codeberg.org/ifreund/zig-xkbcommon/archive/v0.3.0.tar.gz'
)

ZIG_SLOT="0.14"
inherit zig
# TODO verify-sig support
SRC_URI="
	https://codeberg.org/river/river/releases/download/v${PV}/${P}.tar.gz
	${ZBS_DEPENDENCIES_SRC_URI}
"

# river: GPL-3-or-later
# zig-pixman, zig-wayland, zig-wlroots, zig-xkbcommon: MIT
LICENSE="GPL-3+ MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="X +llvm man"

BDEPEND="
	dev-libs/wayland-protocols
	dev-util/wayland-scanner
	man? ( app-text/scdoc )
	|| (
		dev-lang/zig:${ZIG_SLOT}[llvm(+)?]
		dev-lang/zig-bin:${ZIG_SLOT}
	)
"
DEPEND="
	dev-libs/libevdev
	dev-libs/libinput:=
	dev-libs/wayland
	gui-libs/wlroots:0.18[X?]
	x11-libs/libxkbcommon[wayland,X?]
	x11-libs/pixman
"
RDEPEND="${DEPEND}"

DOCS=( "README.md" )

src_configure() {
	local my_zbs_args=(
		-Dstrip=false # Let Portage control this
		-Dpie=true
		-Dno-llvm=$(usex llvm false true)
		-Dman-pages=$(usex man true false)
		-Dxwayland=$(usex X true false)
	)

	zig_src_configure
}

src_install() {
	zig_src_install

	insinto /usr/share/wayland-sessions/
	doins contrib/river.desktop

	insinto /usr/share/river/
	doins -r example/
}
