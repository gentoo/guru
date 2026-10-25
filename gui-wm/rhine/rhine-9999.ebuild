# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
EAPI=8

DESCRIPTION="A powerful tiling window manager for river implementing multiple layout options"
HOMEPAGE="https://codeberg.org/Sivecano/rhine"

declare -g -r -A ZBS_DEPENDENCIES=(
	[mr_tween-0.1.0-WbH78YcBAQD3RF4QfCYFF6EJCYzAzdIU4BHCj0pFI5yq.tar.gz]='https://codeberg.org/Games-by-Mason/mr_tween/archive/v0.1.0.tar.gz'
	[tributary-0.4.0-tqCfW5fFAAC_PBxqMMwGJRlbwU8XThn9b2zIieRvQgDX.tar.gz]='https://codeberg.org/Sivecano/libtributary/archive/ad5ee12ecae34c6aac55c55eeffce50f85cb3856.tar.gz'
	[wayland-0.6.0-lQa1kqz8AQADQmdNJsNhLoNHcnEGEUjrOaPV-dtEnEmX.tar.gz]='https://codeberg.org/ifreund/zig-wayland/archive/v0.6.0.tar.gz'
)

ZIG_SLOT="0.16"
inherit zig

if [[ "${PV}" = "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://codeberg.org/Sivecano/rhine.git"
else
	SRC_URI="
		https://codeberg.org/Sivecano/rhine/archive/${PV}.tar.gz -> ${P}.tar.gz
		${ZBS_DEPENDENCIES_SRC_URI}
	"
	KEYWORDS="~amd64"
	S="${WORKDIR}/${PN}"
fi

LICENSE="AGPL-3"
SLOT="0"
IUSE="+dbus"

DEPEND="
	dev-libs/wayland
	dbus? ( sys-apps/dbus )
"

BDEPEND="
	>=gui-wm/river-0.4.0
	dev-libs/wayland-protocols
	x11-libs/libxkbcommon
"

RDEPEND="${DEPEND}"

src_unpack() {
	if [[ "${PV}" = "9999" ]]; then
		git-r3_src_unpack
		zig_live_src_unpack
	else
		zig_src_unpack
	fi
}

src_configure() {
	local my_zbs_args=(
		-Dnotify=$(usex dbus true false)
		-Dstrip=false # portage handles this
		-Dpie=true
	)

	zig_src_configure
}
