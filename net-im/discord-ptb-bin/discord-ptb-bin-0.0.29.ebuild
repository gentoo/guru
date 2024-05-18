# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PN=${PN/-bin/}
MY_BIN="D${MY_PN/d/}"
MY_BIN="${MY_BIN/-ptb/}PTB"

inherit desktop linux-info pax-utils unpacker xdg

DESCRIPTION="All-in-one voice and text chat"
HOMEPAGE="https://discordapp.com/"
SRC_URI="https://dl-ptb.discordapp.net/apps/linux/${PV}/${MY_PN}-${PV}.deb"

S="${WORKDIR}"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="mirror bindist"

# libXScrnSaver is used through dlopen (bug #825370)
RDEPEND="
	app-accessibility/at-spi2-atk:2
	app-accessibility/at-spi2-core:2
	dev-libs/atk
	dev-libs/expat
	dev-libs/glib:2
	dev-libs/nspr
	dev-libs/nss
	media-libs/alsa-lib
	media-libs/mesa[gbm(+)]
	net-print/cups
	sys-apps/dbus
	sys-libs/glibc
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:3
	x11-libs/libdrm
	x11-libs/libX11
	x11-libs/libxcb
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libxkbcommon
	x11-libs/libXrandr
	x11-libs/libXScrnSaver
	x11-libs/libxshmfence
	x11-libs/pango
"

QA_PREBUILT="
	opt/discord-ptb/${MY_BIN}
	opt/discord-ptb/chrome-sandbox
	opt/discord-ptb/libffmpeg.so
	opt/discord-ptb/libvk_swiftshader.so
	opt/discord-ptb/libvulkan.so
	opt/discord-ptb/libEGL.so
	opt/discord-ptb/libGLESv2.so
	opt/discord-ptb/libVkICD_mock_icd.so
	opt/discord-ptb/swiftshader/libEGL.so
	opt/discord-ptb/swiftshader/libGLESv2.so
	opt/discord-ptb/swiftshader/libvk_swiftshader.so
"

CONFIG_CHECK="~USER_NS"

src_prepare() {
	default

	sed -i \
		-e "s:/usr/share/${MY_PN}/${MY_BIN}:/opt/${MY_PN}/${MY_BIN}:g" \
		usr/share/${MY_PN}/${MY_PN}.desktop || die
}

src_install() {
	newicon usr/share/${MY_PN}/${MY_PN//-ptb}.png ${MY_PN}.png
	domenu usr/share/${MY_PN}/${MY_PN}.desktop

	insinto /opt/${MY_PN}
	doins -r usr/share/${MY_PN}/.
	fperms +x /opt/${MY_PN}/${MY_BIN}
	dosym ../../opt/${MY_PN}/${MY_BIN} usr/bin/${MY_PN}

	pax-mark -m "${ED}"/opt/${MY_PN}/${MY_PN}
}
