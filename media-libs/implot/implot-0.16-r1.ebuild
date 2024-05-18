# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson-multilib

MESON_WRAP_VER="1"

DESCRIPTION="Immediate Mode Plotting"
HOMEPAGE="
	https://github.com/epezent/implot/
"

SRC_URI="https://github.com/epezent/implot/archive/v${PV}.tar.gz -> implot-${PV}.tar.gz"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"

DEPEND="
	media-libs/imgui
"

BDEPEND="
	virtual/pkgconfig
	app-arch/unzip
"

src_prepare() {
	default

	# Use custom meson.build and meson_options.txt to install instead of relay on packages
	cp "${FILESDIR}/${PN}-meson.build" "${S}/meson.build" || die
	sed -i "s/version : 'PV',/version : '${PV}',/g" "${S}/meson.build" || die

	# replace all occurences of imgui headers to use the subfolder
	find . -type f -exec sed -i 's|"imgui.h"|<imgui/imgui.h>|g' {} \; || die
	find . -type f -exec sed -i 's|"imgui_internal.h"|<imgui/imgui_internal.h>|g' {} \; || die
}
