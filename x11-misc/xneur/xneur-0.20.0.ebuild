# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
#
# This ebuild is mostly from https://github.com/Sabayon/for-gentoo/blob/338c13c74bfdfafcc0f723482c05a0ddb591704e/x11-misc/xneur/xneur-0.20.0.ebuild

EAPI=8

inherit autotools xdg

DESCRIPTION="Inplace conversion of text typed in a wrong keyboard layout, like Punto Switcher"
HOMEPAGE="http://www.xneur.ru/"
SRC_URI="https://github.com/AndrewCrewKuznetsov/$PN-devel/raw/master/dists/$PV/xneur_$PV.orig.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="aplay debug gstreamer keylogger libnotify nls openal openmp xosd +spell"

PATCHES=(
	"$FILESDIR/enchant.patch"
	"$FILESDIR/01-fix-arg-parsing.patch"
	"$FILESDIR/gcc-10.patch"
)

COMMON_DEPEND=">=dev-libs/libpcre-5.0
	sys-libs/zlib
	>=x11-libs/libX11-1.1
	x11-libs/libXtst
	gstreamer? ( >=media-libs/gstreamer-0.10.6 )
	!gstreamer? (
		openal? ( >=media-libs/freealut-1.0.1 )
		!openal? (
			aplay? ( >=media-sound/alsa-utils-1.0.17 ) ) )
	libnotify? ( >=x11-libs/libnotify-0.4.0 )
	spell? ( app-text/enchant )
	xosd? ( x11-libs/xosd )"
RDEPEND="${COMMON_DEPEND}
	gstreamer? (
		media-libs/gst-plugins-good
	)
	nls? ( virtual/libintl )"
DEPEND="${COMMON_DEPEND}
	virtual/pkgconfig
	openmp? ( sys-devel/gcc[openmp] )
	nls? ( sys-devel/gettext )"

src_prepare() {
	# Fixes error/warning: no newline at end of file
	# find -name '*.c' -exec sed -i -e '${/[^ ]/s:$:\n:}' {} + || die
	# rm -f m4/{lt~obsolete,ltoptions,ltsugar,ltversion,libtool}.m4 \
	# 	ltmain.sh aclocal.m4 || die

	sed -i -e "s/-Werror -g0//" configure || die
	sed -i -e "s/-Werror -g0//" configure.ac || die
	# epatch "${FILESDIR}/${P}-libnotify-0.7.patch"
	default
	eautoreconf
}

src_configure() {
	myconf="--with-gtk=gtk3"

	if use gstreamer; then
		elog "Using gstreamer for sound output."
		myconf="--with-sound=gstreamer"
	elif use openal; then
		elog "Using openal for sound output."
		myconf="--with-sound=openal"
	elif use aplay; then
		elog "Using aplay for sound output."
		myconf="--with-sound=aplay"
	else
		elog "Sound support disabled."
		myconf="--with-sound=no"
	fi

	econf ${myconf} \
		$(use_with debug) \
		$(use_enable nls) \
		$(use_with spell) \
		$(use_with xosd) \
		$(use_with libnotify) \
		$(use_with keylogger)
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog README NEWS TODO || die
}

pkg_postinst() {
	xdg_icon_cache_update

	# TODO add gxneur, but I have no tray to check it
	#elog "This is command line tool. If you are looking for GUI frontend just"
	#elog "emerge gxneur, which uses xneur transparently as backend."
	#elog ""
	elog "It is recommended to install dictionary for your language"
	elog "(myspell or aspell), for example app-dicts/aspell-ru."
	elog ""
	ewarn "Note: if xneur became slow, try to comment out AddBind options in config file."
}
