# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ZIG_SLOT="0.17"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://codeberg.org/beansprout/beansprout.git"
	inherit git-r3
else
	declare -g -r -A ZBS_DEPENDENCIES=(
		[fcft-3.0.0-zcx6CxQfAABhvjr94DLJpHKt0UEOpTBXVYQyeySRuaVv.tar.gz]='https://codeberg.org/bwbuhse/zig-fcft/archive/58e215cd67928e22856625615ad9aff457b7fdf4.tar.gz'
		[kdl-0.0.0-8rilELEEAgDpp4K7_p6ZmM5DJ9-c9I9j6APAI4SGQKuN.tar.gz]='https://codeberg.org/bwbuhse/zig-kdl/archive/c13744e24d8b347935ec2caa251f8dedf1dde0c8.tar.gz'
		[known_folders-0.0.0-Fy-PJiDLAAB98m3uYUzatrTb2mO2fpvwx2zpSroEtfbO.tar.gz]='https://github.com/ziglibs/known-folders/archive/6da0d0c41b78b9ed2d34fa364fcb81b5ebece6c4.tar.gz'
		[pixman-0.4.0-LClMn_eWAAAa2zACATDpPwjuI5fWlO5cBp_F_M33hnNZ.tar.gz]='https://codeberg.org/ifreund/zig-pixman/archive/v0.4.0.tar.gz'
		[translate_c-2.0.2-Q_BUWvBNBwDnyehSiuAJmdFcMYHYGA-Jc3KiYdrV2Dqx.tar.gz]='https://codeberg.org/ziglang/translate-c/archive/cfac21f3199b2b02ce3fd7db652aa456421fe4ab.tar.gz'
		[wayland-0.7.0-lQa1kuP8AQD5dW7_o-VKLVD_QbqXe7Zob78r2su7Pyex.tar.gz]='https://codeberg.org/ifreund/zig-wayland/archive/v0.7.0.tar.gz'
		[xkbcommon-0.5.0-VDqIe8y3AgDU-cGL02xZplwABH3WbpTimrrgbgTgD_3g.tar.gz]='https://codeberg.org/ifreund/zig-xkbcommon/archive/v0.5.0.tar.gz'
		[aro-0.0.0-JSD1QvCRNwC2O1Jkop9TO6sXb1U1vhrH8FnYK1VdEMKn.tar.gz]='https://codeberg.org/ziglang/arocc/archive/630d99ed60fe61ccabe721f1af60881f8b2adde3.tar.gz'
	)
	S="${WORKDIR}/${PN}"
	KEYWORDS="~amd64"
fi

inherit zig

DESCRIPTION="A tiling window manager for the river Wayland compositor"
HOMEPAGE="https://codeberg.org/beansprout/beansprout"

if [[ ${PV} != 9999 ]]; then
	SRC_URI="
		https://codeberg.org/beansprout/beansprout/archive/v${PV}.tar.gz -> ${P}.tar.gz
		${ZBS_DEPENDENCIES_SRC_URI}
	"
fi

LICENSE="GPL-3"
SLOT="0"

BDEPEND="
	dev-libs/wayland-protocols
	app-text/scdoc
"
DEPEND="
	dev-libs/wayland
	media-libs/fcft
	x11-libs/libxkbcommon
	x11-libs/pixman
"
RDEPEND="${DEPEND}"

src_unpack() {
	if [[ ${PV} == 9999 ]]; then
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
		-Dman-pages=true
	)

	zig_src_configure
}
