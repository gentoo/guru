# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

declare -g -r -A ZBS_DEPENDENCIES=(
	[xkbcommon-0.3.0-VDqIe3K9AQB2fG5ZeRcMC9i7kfrp5m2rWgLrmdNn9azr.tar.gz]='https://codeberg.org/ifreund/zig-xkbcommon/archive/v0.3.0.tar.gz'
	[wayland-0.6.0-lQa1kqz8AQADQmdNJsNhLoNHcnEGEUjrOaPV-dtEnEmX.tar.gz]='https://codeberg.org/ifreund/zig-wayland/archive/v0.6.0.tar.gz'
	[mvzr-0.3.9-ZSOky8FzAQBQ9-GkQnaLjOZZHxrioD8NwY-QyZT6oAyR.tar.gz]='https://github.com/mnemnion/mvzr/archive/refs/tags/v0.3.10.tar.gz'
	[fcft-2.0.0-zcx6C5EaAADIEaQzDg5D4UvFFMjSEwDE38vdE9xObeN9.tar.gz]='https://github.com/kewuaa/zig-fcft/archive/refs/tags/v2.0.0.tar.gz'
	[pixman-0.3.0-LClMnz2VAAAs7QSCGwLimV5VUYx0JFnX5xWU6HwtMuDX.tar.gz]='https://codeberg.org/ifreund/zig-pixman/archive/v0.3.0.tar.gz'
)
ZIG_SLOT="0.16"

inherit xdg zig

DESCRIPTION="A window manager based on River Wayland compositor"
HOMEPAGE="https://github.com/kewuaa/kwm"

if [[ "${PV}" = "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/kewuaa/kwm.git"
else
	SRC_URI="
		https://github.com/kewuaa/kwm/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
		${ZBS_DEPENDENCIES_SRC_URI}
	"
	KEYWORDS="~amd64"
fi

# kwm: GPL-3
# all dependencies: MIT
LICENSE="GPL-3 MIT"
SLOT="0"
IUSE="+bar"

DEPEND="
	dev-libs/wayland
	x11-libs/libxkbcommon
	x11-libs/pixman
	bar? ( media-libs/fcft )
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
		-Dbar=$(usex bar true false)

		# make sure build.zig can pick up default config, must be a relative path
		-Dconfig="../${P}/config.def.zon"
	)

	zig_src_configure
}

src_install() {
	zig_src_install
	rm -r "${ED}/usr/share/doc/kwm/" || die "rm failed"
}
