# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

WX_GTK_VER="3.2-gtk3"
inherit autotools wxwidgets desktop flag-o-matic

DESCRIPTION="Realize the collective dream of sleeping computers from all over the internet"
HOMEPAGE="https://electricsheep.org/"
MY_COMMIT="5fbbb684752be06ccbea41639968aa7f1cc678dd"
SRC_URI="
	https://github.com/scottdraves/electricsheep/archive/${MY_COMMIT}.tar.gz -> ${P}.tar.gz
	https://github.com/scottdraves/electricsheep/pull/126.patch -> electricsheep-remove-convenience.patch
"

S="${WORKDIR}/${PN}-${MY_COMMIT}/client_generic"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="video_cards_nvidia"

DEPEND="dev-lang/lua:5.1
	dev-libs/boost
	dev-libs/expat
	dev-libs/tinyxml
	gnome-base/libgtop
	media-gfx/flam3
	media-libs/freeglut
	media-libs/glee
	media-libs/libpng:*
	media-video/ffmpeg:0
	net-misc/curl
	sys-libs/zlib
	x11-libs/libX11
	x11-libs/libXrender
	x11-libs/wxGTK:${WX_GTK_VER}
	virtual/opengl"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}/electricsheep-disable-vsync.patch"
)

src_prepare() {
	default
	setup-wxwidgets
	eautoreconf
	rm -f DisplayOutput/OpenGL/{GLee.c,GLee.h}
	cd ../
	eapply "${DISTDIR}/electricsheep-remove-convenience.patch"
}

src_configure() {
	# "eselect opengl" doesn't seem to affect link-time paths, so we need to resolve that here
	use video_cards_nvidia && append-ldflags -L/usr/$(get_libdir)/opengl/nvidia/lib
	append-ldflags -lpthread
	econf
	# get rid of the RUNPATH that interferes with hardware accelerated OpenGL drivers
	sed -i -e '/^hardcode_libdir_flag_spec/d' libtool
}

src_install() {
	default
	mv "${ED}/usr/share/doc/electricsheep-2.7b33-svn" "${ED}/usr/share/${PF}" || die
	sed -i "$ a OnlyShowIn=" "${ED}/usr/share/applications/screensavers/electricsheep.desktop"
	domenu "${FILESDIR}/ElectricSheep.desktop"

}
