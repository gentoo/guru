# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools git-r3 udev

DESCRIPTION="OpenOCD - Open On-Chip Debugger (Raspberry Pi Fork)"
HOMEPAGE="https://github.com/raspberrypi/openocd"

EGIT_REPO_URI="https://github.com/raspberrypi/openocd.git"
EGIT_BRANCH="rpi-common"
EGIT_SUBMODULES=()

LICENSE="GPL-2+"
SLOT="0"
IUSE="capstone +cmsis-dap dummy +ftdi gpiod +jlink parport +usb verbose-io"
RESTRICT="strip"

DEPEND="
	acct-group/plugdev
	>=dev-lang/jimtcl-0.79
	capstone? ( dev-libs/capstone )
	cmsis-dap? ( dev-libs/hidapi )
	ftdi? ( dev-embedded/libftdi:= )
	gpiod? ( dev-libs/libgpiod:0/2 )
	jlink? ( >=dev-embedded/libjaylink-0.2.0 )
	usb? ( virtual/libusb:1 )
"
RDEPEND="${DEPEND}"
BDEPEND="virtual/pkgconfig"

src_prepare() {
	default

	AT_NO_RECURSIVE=yes eautoreconf
}

src_configure() {
	local myconf=(
		--program-prefix=rpi-
		--datadir=/usr/share/openocd-rpi
		--infodir=/usr/share/info/rpi-openocd
		--docdir=/usr/share/doc/rpi-openocd
		--enable-amtjtagaccel
		--enable-am335xgpio
		--enable-arm-jtag-ew
		--enable-at91rm9200
		--enable-bcm2835gpio
		--enable-buspirate
		--enable-ep93xx
		--enable-gw16012
		--enable-jtag_dpi
		--enable-sysfsgpio
		--enable-vdebug
		--disable-internal-jimtcl
		--disable-internal-libjaylink
		--disable-parport-giveio
		--disable-werror
		$(use_with capstone)
		$(use_enable cmsis-dap)
		$(use_enable dummy)
		$(use_enable ftdi openjtag)
		$(use_enable ftdi presto)
		$(use_enable ftdi usb-blaster)
		$(use_enable gpiod linuxgpiod)
		$(use_enable jlink)
		$(use_enable parport)
		$(use_enable parport parport_ppdev)
		$(use_enable usb aice)
		$(use_enable usb armjtagew)
		$(use_enable usb ftdi)
		$(use_enable usb osbdm)
		$(use_enable usb opendous)
		$(use_enable usb rlink)
		$(use_enable usb stlink)
		$(use_enable usb ti-icdi)
		$(use_enable usb usbprog)
		$(use_enable usb usb-blaster-2)
		$(use_enable usb ulink)
		$(use_enable usb vsllink)
		$(use_enable verbose-io verbose-jtag-io)
		$(use_enable verbose-io verbose-usb-io)
		$(use_enable verbose-io verbose_usb_comms)
	)

	econf "${myconf[@]}"
}

src_install() {
	default
	dostrip /usr/bin

	mv "${ED}/usr/share/openocd-rpi/openocd/contrib/60-openocd.rules" \
		"${ED}/usr/share/openocd-rpi/openocd/contrib/60-openocd-rpi.rules" || die

	udev_dorules "${ED}"/usr/share/openocd-rpi/openocd/contrib/*.rules
}

pkg_postinst() {
	udev_reload

	elog "To access openocd devices as user you must be in the plugdev group"
	elog "Installed as rpi-openocd"
}

pkg_postrm() {
	udev_reload
}
