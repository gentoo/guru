# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Small screenlocker for Wayland compositors"
HOMEPAGE="https://isaacfreund.com/software/waylock/ https://codeberg.org/ifreund/waylock"

declare -g -r -A ZBS_DEPENDENCIES=(
	[wayland-0.7.0-lQa1kuP8AQD5dW7_o-VKLVD_QbqXe7Zob78r2su7Pyex.tar.gz]='https://codeberg.org/ifreund/zig-wayland/archive/v0.7.0.tar.gz'
	[xkbcommon-0.5.0-VDqIe8y3AgDU-cGL02xZplwABH3WbpTimrrgbgTgD_3g.tar.gz]='https://codeberg.org/ifreund/zig-xkbcommon/archive/v0.5.0.tar.gz'
)

ZIG_SLOT="0.17"
inherit zig

SRC_URI="
	https://codeberg.org/ifreund/waylock/releases/download/v${PV}/${P}.tar.gz
	${ZBS_DEPENDENCIES_SRC_URI}
"

# waylock: ISC
# zig-wayland, zig-xkbcommon: MIT
LICENSE="ISC MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

BDEPEND="
	dev-libs/wayland-protocols
	dev-util/wayland-scanner
"
DEPEND="
	dev-libs/wayland
	sys-libs/pam
	x11-libs/libxkbcommon[wayland]
"
RDEPEND="${DEPEND}"

src_configure() {
	local my_zbs_args=(
		-Dpie=true
		-Dman-pages=false
	)

	zig_src_configure
}

src_install() {
	doman "${FILESDIR}/${PN}.1"

	zig_src_install
}
