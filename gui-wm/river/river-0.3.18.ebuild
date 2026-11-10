# Copyright 2024-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

declare -g -r -A ZBS_DEPENDENCIES=(
	[pixman-0.3.0-LClMnz2VAAAs7QSCGwLimV5VUYx0JFnX5xWU6HwtMuDX.tar.gz]='https://codeberg.org/ifreund/zig-pixman/archive/v0.3.0.tar.gz'
	[wayland-0.7.0-lQa1kuP8AQD5dW7_o-VKLVD_QbqXe7Zob78r2su7Pyex.tar.gz]='https://codeberg.org/ifreund/zig-wayland/archive/v0.7.0.tar.gz'
	[wlroots-0.20.3-jmOlcsh0BACce9rpfvzUI4V3AalGg9GE0QQkvRFoHo1c.tar.gz]='https://codeberg.org/ifreund/zig-wlroots/archive/v0.20.3.tar.gz'
	[xkbcommon-0.5.0-VDqIe8y3AgDU-cGL02xZplwABH3WbpTimrrgbgTgD_3g.tar.gz]='https://codeberg.org/ifreund/zig-xkbcommon/archive/v0.5.0.tar.gz'
	[translate_c-2.0.2-Q_BUWvBNBwDnyehSiuAJmdFcMYHYGA-Jc3KiYdrV2Dqx.tar.gz]='https://codeberg.org/ziglang/translate-c/archive/cfac21f3199b2b02ce3fd7db652aa456421fe4ab.tar.gz'
	[aro-0.0.0-JSD1QvCRNwC2O1Jkop9TO6sXb1U1vhrH8FnYK1VdEMKn.tar.gz]='https://codeberg.org/ziglang/arocc/archive/630d99ed60fe61ccabe721f1af60881f8b2adde3.tar.gz'
)
ZIG_SLOT="0.17"

inherit zig

DESCRIPTION="A dynamic tiling Wayland compositor"
HOMEPAGE="https://isaacfreund.com/software/river/ https://codeberg.org/river/river-classic"

if [[ "${PV}" == "0.3.9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://codeberg.org/river/river-classic.git"
else
	# TODO verify-sig support
	SRC_URI="
		https://codeberg.org/river/river-classic/releases/download/v${PV}/river-classic-${PV}.tar.gz
		${ZBS_DEPENDENCIES_SRC_URI}
	"
	S="${WORKDIR}/river-classic-${PV}"
	KEYWORDS="~amd64"
fi

# river: GPL-3-or-later
# zig-pixman, zig-wayland, zig-wlroots, zig-xkbcommon: MIT
LICENSE="GPL-3+ MIT"
SLOT="0/classic"
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
	gui-libs/wlroots:0.20[X?]
	x11-libs/libxkbcommon[wayland,X?]
	x11-libs/pixman
"
RDEPEND="${DEPEND}"

DOCS=( "README.md" )

BUILD_DIR="${S}"

src_unpack() {
	if [[ "${PV}" == "0.3.9999" ]]; then
		git-r3_src_unpack
		zig_live_src_unpack
	else
		zig_src_unpack
	fi
}

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
