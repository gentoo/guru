# Copyright 2019-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

COMMIT="98cbf07def9604f92fd74ea2964d483347388909"

inherit desktop linux-mod xdg

DESCRIPTION="Use android phone as webcam, using a v4l device driver and app"
HOMEPAGE="https://www.dev47apps.com/droidcam/linuxx/
	https://github.com/aramg/droidcam"
SRC_URI="https://github.com/aramg/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

KEYWORDS="~amd64"
LICENSE="droidcam"
SLOT="0"

# Requires connection to android phone
RESTRICT="test"

BDEPEND="media-libs/libjpeg-turbo"

RDEPEND="x11-libs/gtk+:2"

S="${WORKDIR}/${PN}-${COMMIT}/linux"

PATCHES="${FILESDIR}/${PN}-libjpeg-location.patch"

CONFIG_CHECK="VIDEO_DEV"
MODULE_NAMES="v4l2loopback-dc(video:${S}/v4l2loopback:${S}/v4l2loopback)"
MODULESD_V4L2LOOPBACK_DC_ENABLED="yes"
BUILD_TARGETS="all"

src_configure() {
	set_arch_to_kernel
	default
}

src_compile() {
	default
	KERNELRELEASE="${KV_FULL}" linux-mod_src_compile
}

src_test() {
	pushd "v4l2loopback"
	default
	./test || die
	popd
}

src_install() {
	linux-mod_src_install
	dobin "${PN}"
	dobin "${PN}-cli"

	newicon -s 32x32 icon.png ${PN}.png
	newicon -s 64x64 icon2.png ${PN}.png
	make_desktop_entry ${PN} "Droidcam" ${PN} 'AudioVideo;Video'

	# The cli and gui do not auto load the module if unloaded (why not tho?)
	# so we just put it in modules-load.d to make sure it always works
	insinto /usr/lib/modules-load.d/
	doins "${FILESDIR}/v4l2loopback-dc.conf"
}

pkg_postinst() {
	linux-mod_pkg_postinst
	xdg_pkg_postinst

	elog "To use this, you'll need to download the android app as well:"
	elog "Free version: https://play.google.com/store/apps/details?id=com.dev47apps.droidcam"
	elog "Paid version: https://play.google.com/store/apps/details?id=com.dev47apps.droidcamx"
}
