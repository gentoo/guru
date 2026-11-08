# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
EAPI=8

DESCRIPTION="A powerful tiling window manager for river implementing multiple layout options"
HOMEPAGE="https://codeberg.org/Sivecano/rhine"

declare -g -r -A ZBS_DEPENDENCIES=(
	[mr_tween-0.3.0-WbH78YegAQDRCaCQZo8HQMjDVlnmfsNwf1AJn3uIx_vK.tar.gz]='https://codeberg.org/Games-by-Mason/mr_tween/archive/b1bd6bf833e7aaf490026cf7a495e8f4f1285a4e.tar.gz'
	[tributary-0.5.1-tqCfW27DAAAHoFA0ZWGt3ItwHqlSzZ5bXXhvz4p76LKe.tar.gz]='https://codeberg.org/Sivecano/libtributary/archive/0.5.1.tar.gz'
	[wayland-0.7.0-lQa1kuP8AQD5dW7_o-VKLVD_QbqXe7Zob78r2su7Pyex.tar.gz]='https://codeberg.org/ifreund/zig-wayland/archive/v0.7.0.tar.gz'
	[dtram-0.0.1-WTB_FZG3AACYAauKUacprrbY2AOd7Suny0uzDrc3rv0W.tar.gz]='https://codeberg.org/Sivecano/dtram/archive/0.0.1.tar.gz'
)

ZIG_SLOT="0.17"
inherit zig

SRC_URI="
	https://codeberg.org/Sivecano/rhine/archive/${PV}.tar.gz -> ${P}.tar.gz
	${ZBS_DEPENDENCIES_SRC_URI}
"

S="${WORKDIR}/${PN}"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+dbus"

DEPEND="
	dev-libs/wayland
"

BDEPEND="
	>=gui-wm/river-0.4.0
	dev-libs/wayland-protocols
	x11-libs/libxkbcommon
"

RDEPEND="${DEPEND}"

src_configure() {
	local my_zbs_args=(
		-Ddbus=$(usex dbus true false)
		-Dstrip=false # portage handles this
		-Dpie=true
	)

	zig_src_configure
}
