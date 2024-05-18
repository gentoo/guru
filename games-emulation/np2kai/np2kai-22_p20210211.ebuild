# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit xdg cmake

MY_REV=3e8fedc7c1c6f68faa26589187512474a766ee9e
MY_SDL2_CMAKE_MODULES_REV=ad006a3daae65a612ed87415037e32188b81071e

DESCRIPTION="NP2kai is an emulator for the japanese PC-98 series of computers"
HOMEPAGE="https://domisan.sakura.ne.jp/article/np2kai/np2kai.html"
SRC_URI="
	https://github.com/AZO234/NP2kai/archive/${MY_REV}.tar.gz -> ${P}.tar.gz
	https://github.com/aminosbh/sdl2-cmake-modules/archive/${MY_SDL2_CMAKE_MODULES_REV}.tar.gz \
		-> sdl2-cmake-modules-${MY_SDL2_CMAKE_MODULES_REV}.tar.gz
"

S="${WORKDIR}/NP2kai-${MY_REV}"

LICENSE="MIT BSD"
SLOT="0"
KEYWORDS="~amd64"

IUSE="+i286 ia32 haxm +sdl2 +X"
REQUIRED_USE="|| ( X sdl2 ) ^^ ( i286 ia32 )"

# TODO: migrate from gtk2 to gtk3
DEPEND="
	dev-libs/openssl:=
	virtual/libusb:1
	sdl2? (
		media-libs/libsdl2
		media-libs/sdl2-ttf
		media-libs/sdl2-mixer
	)
	!sdl2? (
		media-libs/libsdl
		media-libs/sdl-mixer
		media-libs/sdl-ttf
	)
	X? (
		dev-libs/glib
		media-libs/freetype
		media-libs/fontconfig
		x11-libs/gtk+:2
		x11-libs/libX11
	)
"
RDEPEND="${DEPEND}"

src_prepare() {
	sed -i '+s/CONFIGURATIONS Release/CONFIGURATIONS Gentoo/g' CMakeLists.txt || die
	mv "${WORKDIR}"/sdl2-cmake-modules-${MY_SDL2_CMAKE_MODULES_REV}/* \
		"${S}"/cmake/sdl2-cmake-modules/ || die

	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-D BUILD_I286=$(usex i286)
		-D BUILD_HAXM=$(usex haxm)
		-D BUILD_SDL=ON
		-D BUILD_X=$(usex X)
		-D USE_SDL2=$(usex sdl2)
	)

	NP2KAI_VERSION=${PV} NP2KAI_HASH=${MY_REV} cmake_src_configure
}

pkg_postinst() {
	xdg_pkg_postinst
	if [[ -z ${REPLACING_VERSIONS} ]]; then
		if use i286 && use haxm; then
			local cfgname="{xnp2kai,xnp21kai}"
		elif use i286 && ! use haxm; then
			local cfgname="xnp2kai"
		else
			local cfgname="xnp21kai"
		fi

		elog  	"Japanese fonts are needed to use the emulator."
		elog   	"Please run the following command to configure them:"
		elog	"mkdir -p ~/.config/${cfgname} && ln -s /path/to/font.ttf ~/.config/${cfgname}/default.ttf && rm ~/.config/${cfgname}/font.tmp"
		elog
		elog	"Neko project 2 requires a BIOS dump to work."
		elog	"Please dump the BIOS from your device and put the files under ~/.config/${cfgname}"
	fi
}
