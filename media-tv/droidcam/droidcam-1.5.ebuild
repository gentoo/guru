# Copyright 2019-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop eutils linux-mod readme.gentoo-r1 xdg

DESCRIPTION="Use android phone as webcam, using a v4l device driver and app"
HOMEPAGE="https://www.dev47apps.com/droidcam/linux/
	https://github.com/aramg/droidcam"
SRC_URI="https://github.com/aramg/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

KEYWORDS="~amd64"
LICENSE="GPL-2"
SLOT="0"

IUSE="gtk"

# Requires connection to android phone
RESTRICT="test"

DEPEND="
	=app-pda/libusbmuxd-1*
	dev-libs/glib
	dev-libs/libappindicator:3
	dev-util/android-tools
	media-libs/alsa-lib
	media-libs/libjpeg-turbo
	>=media-libs/speex-1.2.0-r1
	media-video/ffmpeg
	gtk? (
		dev-cpp/gtkmm:3.0
		x11-libs/gdk-pixbuf
		x11-libs/gtk+:3
		x11-libs/libX11
		x11-libs/pango
	)
"

BDEPEND="virtual/pkgconfig"

S="${WORKDIR}/${P}/linux"

DOCS=( README.md README-DKMS.md )
DISABLE_AUTOFORMATTING="true"
DOC_CONTENTS="
		The default resolution for v4l2loopback-dc[1] is 640x480. You can override the
		value by copying droidcam.conf.default to /etc/modprobe.d/droidcam.conf
		and modifying 'width' and 'height'.
		[1] https://github.com/aramg/droidcam/issues/56
"

BUILD_TARGETS="all"
MODULE_NAMES="v4l2loopback-dc(video:${S}/v4l2loopback:${S}/v4l2loopback)"
MODULESD_V4L2LOOPBACK_DC_ENABLED="yes"

CONFIG_CHECK="~SND_ALOOP VIDEO_DEV MEDIA_SUPPORT MEDIA_CAMERA_SUPPORT"
ERROR_SND_ALOOP="CONFIG_SND_ALOOP is required for audio support"

PATCHES="${FILESDIR}/${PN}-makefile-fixes.patch"

src_prepare() {
	if ! use gtk ; then
		sed -i -e '/cflags gtk+/d' Makefile
	else
		xdg_src_prepare
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

pkg_preinst() {
	xdg_pkg_preinst
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
	insinto /etc/modules-load.d
	doins "${FILESDIR}"/${PN}-video.conf
	if linux_config_exists ; then
		if linux_chkconfig_module SND_ALOOP ; then
			doins "${FILESDIR}"/${PN}-audio.conf
		fi
	fi

	newdoc "${FILESDIR}"/${PN}-modprobe.conf ${PN}.conf.default
	einstalldocs
	linux-mod_src_install
}

pkg_postinst() {
	if use gtk ; then
		xdg_pkg_postinst
	else
		elog
		elog "Only droidcam-cli has been installed since 'gtk' flag was not set"
		elog
	fi

	linux-mod_pkg_postinst
	readme.gentoo_print_elog

	elog "Links to the Android/iPhone/iPad apps can be reached at"
	elog "https://www.dev47apps.com/"
}

pkg_postrm() {
	if use gtk ; then
		xdg_pkg_postrm
	fi

	linux-mod_pkg_postrm
}
