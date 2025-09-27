# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker xdg

DESCRIPTION="Flash OS images to SD cards & USB drives, safely and easily."
HOMEPAGE="https://etcher.balena.io"
SRC_URI="https://github.com/balena-io/etcher/releases/download/v${PV}/balena-etcher_${PV}_amd64.deb"
S="${WORKDIR}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="-* ~amd64"

RESTRICT="mirror test"

RDEPEND="
	app-accessibility/at-spi2-core:2
	app-arch/xz-utils
	dev-libs/expat
	dev-libs/glib:2
	dev-libs/nspr
	dev-libs/nss
	media-libs/alsa-lib
	media-libs/mesa
	net-print/cups
	sys-apps/dbus
	sys-auth/polkit
	sys-libs/glibc
	virtual/libudev
	x11-libs/cairo
	x11-libs/gtk+:3
	x11-libs/libnotify
	x11-libs/libX11
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXrandr
	x11-libs/libXScrnSaver
	x11-libs/libdrm
	x11-libs/libxcb
	x11-libs/libxkbcommon
	x11-libs/pango
"
BDEPEND="
	dev-util/patchelf
"

QA_PREBUILT="
	usr/lib/balena-etcher/balena-etcher
	usr/lib/balena-etcher/resources/etcher-util
"
QA_PRESTRIPPED="
	usr/lib/balena-etcher/resources/app.asar.unpacked/.webpack/renderer/native_modules/prebuilds/linux-x64/node.napi.node
	usr/lib/balena-etcher/resources/app.asar.unpacked/.webpack/renderer/native_modules/prebuilds/linux-x64/node.napi1.node
"

src_unpack() {
	unpack_deb ${A}
}

src_prepare() {
	mv "${WORKDIR}/usr/share/doc/balena-etcher/" "${WORKDIR}/usr/share/doc/${PF}" || die

	# Weird symlink
	rm "${WORKDIR}/usr/lib/balena-etcher/balenaEtcher" || die

	default
}

src_install() {
	mv * "${D}" || die
}
