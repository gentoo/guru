# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
EAPI=8

DESCRIPTION="A flexible demon to provide live input configuration for river"
HOMEPAGE="https://codeberg.org/Sivecano/channel"

declare -g -r -A ZBS_DEPENDENCIES=(
	[tributary-0.5.1-tqCfW27DAAAHoFA0ZWGt3ItwHqlSzZ5bXXhvz4p76LKe.tar.gz]='https://codeberg.org/Sivecano/libtributary/archive/0.5.1.tar.gz'
	[wayland-0.7.0-lQa1kuP8AQD5dW7_o-VKLVD_QbqXe7Zob78r2su7Pyex.tar.gz]='https://codeberg.org/ifreund/zig-wayland/archive/v0.7.0.tar.gz'
	[dtram-0.0.1-WTB_FZG3AACYAauKUacprrbY2AOd7Suny0uzDrc3rv0W.tar.gz]='https://codeberg.org/Sivecano/dtram/archive/0.0.1.tar.gz'
)

ZIG_SLOT="0.17"
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
