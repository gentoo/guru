# Copyright 2024-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A dynamic tiling Wayland compositor"
HOMEPAGE="https://isaacfreund.com/software/river/ https://codeberg.org/river/river"

ZIG_SLOT="0.15"
inherit eapi9-ver zig

if [[ "${PV}" = "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://codeberg.org/river/river.git"
else
	# TODO verify-sig support
	SRC_URI="
		https://codeberg.org/river/river/releases/download/v${PV}/${P}.tar.gz
		${ZBS_DEPENDENCIES_SRC_URI}
	"
	KEYWORDS="~amd64"
fi

# river: GPL-3-or-later
# zig-pixman, zig-wayland, zig-wlroots, zig-xkbcommon: MIT
LICENSE="GPL-3+ MIT"
SLOT="0"
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
	"${FILESDIR}/river-0.4.1-fix-scdoc-path.patch"
)

src_unpack() {
	if [[ "${PV}" = "9999" ]]; then
		git-r3_src_unpack
		zig_live_fetch
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
	)

	zig_src_configure
}

src_install() {
	zig_src_install

	insinto /usr/share/wayland-sessions/
	doins contrib/river.desktop
}

pkg_postinst() {
	if ver_replacing -lt 0.4; then
		ewarn "River 0.4.x is a significant rework of the compositor's architecture,"
		ewarn "and requires significant manual migration. If you would like to stay on"
		ewarn "river 0.3.x, simply add '>=gui-wm/river-0.4' to your package.mask to"
		ewarn "use river-classic continuation of the 0.3.x branch."
	fi

	einfo "River requires an separate window manager in addition to the main"
	einfo "compositor. For some options, see gui-wm/canoe and gui-wm/kwm."
}
