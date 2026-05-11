# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="OXWM — DWM but better. Dynamic window manager written in Zig with Lua config"
HOMEPAGE="https://github.com/tonybanters/oxwm"

declare -g -r -A ZBS_DEPENDENCIES=(
	[N-V-__8AAKEzFAAA695b9LXBhUSVK5MAV_VKSm1mEj3Acbze.tar.gz]='https://www.lua.org/ftp/lua-5.4.8.tar.gz'
)

ZIG_SLOT="0.15"
inherit zig

COMMIT="f699f6d1ff9e07cdd3831591bda84400e784b2c1"
SRC_URI="https://codeload.github.com/tonybanters/oxwm/tar.gz/${COMMIT} -> ${P}.tar.gz
	${ZBS_DEPENDENCIES_SRC_URI}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	x11-libs/libX11
	x11-libs/libXft
	x11-libs/libXinerama
	media-libs/fontconfig
	media-libs/freetype
	dev-lang/lua
"

DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

S="${WORKDIR}/${P}"

src_unpack() {
	zig_src_unpack

	local dir
	for dir in "${WORKDIR}"/*/; do
		dir="${dir%/}"
		[[ -d "${dir}" ]] || continue
		# skip ZBS hash directories
		if [[ "${dir}" == *"__8AAKEzF"* ]]; then
			continue
		fi
		if [[ "${dir}" != "${S}" ]]; then
			mv "${dir}" "${S}" || die "Failed to rename source directory"
			break
		fi
	done
}

src_prepare() {
	zig_src_prepare
	default
}

src_install() {
	zig_src_install

	insinto /usr/share/xsessions
	doins "${S}/resources/oxwm.desktop" 2>/dev/null || true

	insinto /usr/share/oxwm
	doins -r "${S}/templates"

	doman "${S}/resources/oxwm.1" 2>/dev/null || true
}

pkg_postinst() {
	elog "OXWM installed successfully!"
	elog "First launch will create ~/.config/oxwm/config.lua"
	elog "Or run: oxwm --init"
}