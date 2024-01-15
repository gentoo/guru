# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="NP2kai is an emulator for the japanese PC-98 series of computers"
HOMEPAGE="https://domisan.sakura.ne.jp/article/np2kai/np2kai.html"
SRC_URI="https://github.com/AZO234/NP2kai/archive/refs/tags/rev.${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="sdl +sdl2 +i286 ia32 haxm"
REQUIRED_USE="^^ ( sdl sdl2 )"

# Configure crashes if sdl AND sdl2 are not present, even if the options are off
# It also requires sdl2-ttf even when building for sdl
# TODO: test musl
# TODO: migrate from gtk2 to gtk3
DEPEND="media-libs/libsdl
	media-libs/libsdl2
	sdl? (
		media-libs/sdl-mixer
		media-libs/sdl-ttf
	)
	sdl2? (
		media-libs/sdl2-mixer
	)
	media-libs/sdl2-ttf
	virtual/libusb:1
	x11-base/xorg-server
	x11-libs/gtk+:2"
RDEPEND="${DEPEND}"
BDEPEND="dev-build/automake"

S="${WORKDIR}/NP2kai-rev.${PV}/x11"

PATCHES=(
	"${FILESDIR}/${P}-autogen.patch"
)

# TODO: add a die statement to autogen
src_configure() {
	bash "${S}/autogen.sh"
	if use i286 && use ia32 && use haxm ; then
		features=("--enable-build-all")
	else
		features=($(use_enable ia32) $(use_enable haxm))
	fi
	local myeconfargs=(
		$(use_enable sdl)
		$(use_enable sdl sdlmixer)
		$(use_enable sdl sdlttf)
		$(use_enable sdl2)
		$(use_enable sdl2 sdl2mixer)
		$(use_enable sdl2 sdl2ttf)
	)
	econf "${myeconfargs[@]}" "${features}"
}

pkg_postinst() {
	if [[ -z ${REPLACING_VERSIONS} ]] ; then
		if [ use i286 && use ia32 && use haxm ] ; then
			cfgname="{xnp2kai, xnp21kai}"
		elif [ ! use ia32 && ! use haxm ] ; then
			cfgname="xnp2kai"
		else
			cfgname="xnp21kai"
		fi

		elog  	"Japanese fonts are needed to use the emulator."
		elog   	"Please run the following command to configure them:"
		elog	"mkdir -p ~/.config/${cfgname} && ln -s /path/to/font.ttf ~/.config/${cfgname}/default.ttf && rm ~/.config/${cfgname}/font.tmp"

		elog	"Neko project 2 requires a BIOS dump to work."
		elog	"Please dump the BIOS from your device and put the files under ~/.config/${cfgname}"
	fi
}
