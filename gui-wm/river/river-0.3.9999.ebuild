# Copyright 2024-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A dynamic tiling Wayland compositor"
HOMEPAGE="https://isaacfreund.com/software/river/ https://codeberg.org/river/river-classic"

ZIG_SLOT="0.15"
inherit zig

if [[ "${PV}" = "0.3.9999" ]]; then
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
	gui-libs/wlroots:0.19[X?]
	x11-libs/libxkbcommon[wayland,X?]
	x11-libs/pixman
"
RDEPEND="${DEPEND}"

DOCS=( "README.md" )

PATCHES=(
	"${FILESDIR}/${PN}-0.3.12-fix-scdoc-path.patch"
)

src_unpack() {
	if [[ "${PV}" = "0.3.9999" ]]; then
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
