# Copyright 2024-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A dynamic tiling Wayland compositor"
HOMEPAGE="https://isaacfreund.com/software/river/ https://codeberg.org/river/river-classic"

declare -g -r -A ZBS_DEPENDENCIES=(
	[pixman-0.3.0-LClMnz2VAAAs7QSCGwLimV5VUYx0JFnX5xWU6HwtMuDX.tar.gz]='https://codeberg.org/ifreund/zig-pixman/archive/v0.3.0.tar.gz'
	[wayland-0.4.0-lQa1khbMAQAsLS2eBR7M5lofyEGPIbu2iFDmoz8lPC27.tar.gz]='https://codeberg.org/ifreund/zig-wayland/archive/v0.4.0.tar.gz'
	[wlroots-0.19.3-jmOlcuL_AwBHhLCwpFsXbTizE3q9BugFmGX-XIxqcPMc.tar.gz]='https://codeberg.org/ifreund/zig-wlroots/archive/v0.19.3.tar.gz'
	[xkbcommon-0.3.0-VDqIe3K9AQB2fG5ZeRcMC9i7kfrp5m2rWgLrmdNn9azr.tar.gz]='https://codeberg.org/ifreund/zig-xkbcommon/archive/v0.3.0.tar.gz'
)

ZIG_SLOT="0.15"
inherit zig
# TODO verify-sig support
SRC_URI="
	https://codeberg.org/river/river-classic/releases/download/v${PV}/river-classic-${PV}.tar.gz
	${ZBS_DEPENDENCIES_SRC_URI}
"
S="${WORKDIR}/river-classic-${PV}"

# river: GPL-3-or-later
# zig-pixman, zig-wayland, zig-wlroots, zig-xkbcommon: MIT
LICENSE="GPL-3+ MIT"
SLOT="0/classic"
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
	gui-libs/wlroots:0.19[X?]
	x11-libs/libxkbcommon[wayland,X?]
	x11-libs/pixman
"
RDEPEND="${DEPEND}"

DOCS=( "README.md" )

PATCHES=(
	"${FILESDIR}/${PN}-0.3.12-fix-scdoc-path.patch"
)

src_configure() {
	local my_zbs_args=(
		-Dstrip=false # Let Portage control this
		-Dpie=true
		-Dman-pages=$(usex man true false)
		-Dxwayland=$(usex X true false)
		-Dfish-completion=true
		-Dzsh-completion=true
		-Dbash-completion=true
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

pkg_postinst() {
	ewarn "Starting from river 0.3.13, maintenance of the river 0.3.x branch has"
	ewarn "been moved to https://codeberg.org/river/river-classic to prepare for"
	ewarn "the upcoming river 0.4 release, which is a significant rework of the"
	ewarn "compositor's architecture. If you wish to stay on 0.3.x when 0.4 is"
	ewarn "released, mask >=gui-wm/river-0.4 using /etc/portage/package.mask."
}
