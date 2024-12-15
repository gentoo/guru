# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

declare -r -A ZBS_DEPENDENCIES=(
	[zig-pixman-12209db20ce873af176138b76632931def33a10539387cba745db72933c43d274d56.tar.gz]='https://codeberg.org/ifreund/zig-pixman/archive/v0.2.0.tar.gz'
	[zig-wayland-1220687c8c47a48ba285d26a05600f8700d37fc637e223ced3aa8324f3650bf52242.tar.gz]='https://codeberg.org/ifreund/zig-wayland/archive/v0.2.0.tar.gz'
	[zig-wlroots-122083317b028705b5d27be12976feebf17066a4e51802b3b5e9f970bec580e433e1.tar.gz]='https://codeberg.org/ifreund/zig-wlroots/archive/v0.18.1.tar.gz'
	[zig-xkbcommon-1220c90b2228d65fd8427a837d31b0add83e9fade1dcfa539bb56fd06f1f8461605f.tar.gz]='https://codeberg.org/ifreund/zig-xkbcommon/archive/v0.2.0.tar.gz'
)

ZIG_SLOT="0.13"
inherit zig

DESCRIPTION="A dynamic tiling Wayland compositor"
HOMEPAGE="https://isaacfreund.com/software/river/ https://codeberg.org/river/river"
# TODO verify-sig support
SRC_URI="
	https://codeberg.org/river/river/archive/v${PV}.tar.gz -> ${P}.tar.gz
	${ZBS_DEPENDENCIES_SRC_URI}
"
S="${WORKDIR}/${PN}"

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

PATCHES=( "${FILESDIR}/${P}-fix-no-lazypath.patch" )

DOCS=( "README.md" )

src_unpack() {
	zig_src_unpack
}

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
