# Copyright 2019-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop eutils linux-mod readme.gentoo-r1 xdg

DESCRIPTION="Use android phone as webcam, using a v4l device driver and app"
HOMEPAGE="https://www.dev47apps.com/droidcam/linuxx/
	https://github.com/aramg/droidcam"
SRC_URI="https://github.com/aramg/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

KEYWORDS="~amd64"
LICENSE="GPL-2"
SLOT="0"

IUSE="gtk"

# Requires connection to android phone
RESTRICT="test"

DEPEND="
	gtk? (
		dev-cpp/gtkmm:3.0
		media-video/ffmpeg
	)
	=app-pda/libusbmuxd-1*
	media-libs/alsa-lib
"

BDEPEND="
	media-libs/libjpeg-turbo
	>=media-libs/speex-1.2.0-r1
	virtual/pkgconfig
"

S="${WORKDIR}/${P}/linux"

PATCHES="${FILESDIR}/${PN}-makefile-fixes.patch"

DOCS=( README.md README-DKMS.md )
DISABLE_AUTOFORMATTING="true"
DOC_CONTENTS="
		The default resolution for v4l2loopback-dc[1] is 640x480. You can override these
		values in /etc/modprobe.d/v4l2loopback-dc.conf
		and modifying 'width' and 'height'.
		[1] https://github.com/aramg/droidcam/issues/56
"

BUILD_TARGETS="all"
MODULE_NAMES="v4l2loopback-dc(video:${S}/v4l2loopback:${S}/v4l2loopback)"
CONFIG_CHECK="VIDEO_DEV ~SND_ALOOP MEDIA_SUPPORT MEDIA_CAMERA_SUPPORT"
ERROR_SND_ALOOP="CONFIG_SND_ALOOP: missing, required for audio support"
MODULESD_V4L2LOOPBACK_DC_ENABLED="yes"

src_prepare() {
	default
	if ! use gtk ; then
		sed -i -e '/cflags gtk+/d' Makefile
	fi
	linux-mod_pkg_setup
}

src_configure() {
	set_arch_to_kernel
	default
}

src_compile() {
	if use gtk ; then
		emake droidcam
	fi
	emake droidcam-cli
	KERNELRELEASE="${KV_FULL}" linux-mod_src_compile
}

src_test() {
	pushd "v4l2loopback"
	default
	./test || die
	popd
}

src_install() {
	if use gtk ; then
		dobin droidcam
		newicon -s 32 icon.png droidcam.png
		newicon -s 48 icon2.png droidcam.png
		make_desktop_entry "${PN}" "DroidCam Client" "${PN}" AudioVideo
	fi
	dobin "${PN}-cli"

	readme.gentoo_create_doc

	# The cli and gui do not auto load the module if unloaded (why not tho?)
	# so we just put it in modules-load.d to make sure it always works
	insinto /usr/lib/modules-load.d/
	doins "${FILESDIR}/v4l2loopback-dc.conf"

	einstalldocs
	linux-mod_src_install
}

pkg_postinst() {
	linux-mod_pkg_postinst

	if use gtk ; then
		xdg_pkg_postinst
	fi

	readme.gentoo_print_elog

	elog ""
	elog "To use this package, you'll need to download the android app as well:"
	elog "Free version: https://play.google.com/store/apps/details?id=com.dev47apps.droidcam"
	elog "Paid version: https://play.google.com/store/apps/details?id=com.dev47apps.droidcamx"

	elog ""
	optfeature "to connection with USB via ADB instead of over wifi" dev-util/android-tools
}

pkg_postrm() {
	if use gtk ; then
		xdg_pkg_postrm
	fi

	linux-mod_pkg_postrm
}
