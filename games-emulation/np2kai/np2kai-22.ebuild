# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="NP2kai is an emulator for the japanese PC-98 series of computers."
HOMEPAGE="https://domisan.sakura.ne.jp/article/np2kai/np2kai.html"
SRC_URI="https://github.com/AZO234/NP2kai/archive/refs/tags/rev.${PV}.tar.gz -> ${P}.tar.gz"

PATCHES=(
	"${FILESDIR}/${P}-autogen.patch"
)

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

IUSE="sdl +i286 ia32 haxm"

# Configure crashes if sdl AND sdl2 are not present, even if the options are off
# It also requires sdl2-ttf even when building for sdl
DEPEND="sys-libs/glibc
	media-libs/libsdl
	sdl? ( media-libs/sdl-mixer )
	sdl? ( media-libs/sdl-ttf )
	media-libs/libsdl2
	!sdl? ( media-libs/sdl2-mixer )
	media-libs/sdl2-ttf
	virtual/libusb
	x11-base/xorg-server
	x11-libs/gtk+:2"

RDEPEND="${DEPEND}"
BDEPEND="sys-devel/gcc
	sys-devel/automake
	dev-util/cmake"

S=${WORKDIR}/NP2kai-rev.${PV}/x11

src_configure() {
	bash ${S}/autogen.sh
	sdlconf=$(usex sdl "--enable-sdl --enable-sdlmixer --enable-sdlttf
						--disable-sdl2 --disable-sdl2mixer --disable-sdl2ttf" \
						"--enable-sdl2 --enable-sdl2mixer --enable-sdl2ttf
						--disable-sdl --disable-sdlmixer --disable-sdlttf" )
	features=$(	if use i286 && use ia32 && use haxm ; \
					then echo --enable-build-all ; \
					else echo $(use_enable ia32) $(use_enable haxm) ; \
				fi )
	econf ${sdlconf} ${features}
}

pkg_postinst() {
	if [ "${features}" = "--enable-build-all" ] ; then 
		cfgname="{xnp2kai, xnp21kai}"
	elif ! use ia32 && ! use haxm ; then
		cfgname="xnp2kai"
	else
		cfgname="xnp21kai"
	fi

	elog  	"Japanese fonts are needed to use the emulator."
	elog   	"Please run the following command to configure them:"
	elog	"mkdir -p ~/.config/${cfgname} && ln -s /path/to/font.ttf ~/.config/${cfgname}/default.ttf && rm ~/.config/${cfgname}/font.tmp"

	elog	"Neko project 2 requires a BIOS dump to work."
	elog	"Please dump the BIOS from your device and put the files under ~/.config/${cfgname}"
}
