# Copyright 2022-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker xdg

DESCRIPTION="The official unity tool for manager Unity Engines and projects"
HOMEPAGE="https://unity.com/"

SRC_URI="
	https://hub.unity3d.com/linux/repos/deb/pool/main/u/unity/unityhub_amd64/${PN}-amd64-${PV}.deb
"
S="${WORKDIR}"

LICENSE="Unity-TOS"

SLOT="0"
KEYWORDS="~amd64"

RESTRICT="bindist mirror strip test"

RDEPEND="
	app-accessibility/at-spi2-core:2
	app-alternatives/cpio
	dev-libs/expat
	dev-libs/glib:2
	dev-libs/nspr
	dev-libs/nss
	dev-util/lttng-ust:0/2.12
	media-libs/alsa-lib
	media-libs/mesa
	net-print/cups
	sys-apps/dbus
	sys-libs/zlib
	x11-libs/cairo
	x11-libs/gtk+:3
	x11-libs/libX11
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXrandr
	x11-libs/libdrm
	x11-libs/libxcb
	x11-libs/libxkbcommon
	x11-libs/pango
"

QA_PREBUILT="*"

src_install() {
	mv "usr/share/doc/${PN}" "usr/share/doc/${P}" || die
	mv ./* "${ED}" || die

	dodir usr/bin
	dosym -r /opt/unityhub/unityhub /usr/bin/unityhub
	docompress -x "/usr/share/doc/${P}/changelog.gz"
}
