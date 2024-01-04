# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN=${PN/-bin/}
MY_BIN="D${MY_PN/d/}"
MY_BIN="${MY_BIN/-canary/}Canary"

inherit desktop linux-info pax-utils unpacker xdg

DESCRIPTION="All-in-one voice and text chat"
HOMEPAGE="https://discord.com/"
SRC_URI="https://dl-canary.discordapp.net/apps/linux/${PV}/${MY_PN}-${PV}.deb"
S="${WORKDIR}"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="bindist mirror strip test"

RDEPEND="
	>=app-accessibility/at-spi2-core-2.46.0
	dev-libs/expat
	dev-libs/glib:2
	dev-libs/nspr
	dev-libs/nss
	media-libs/alsa-lib
	media-libs/fontconfig:1.0
	media-libs/freetype:2
	media-libs/mesa
	net-print/cups
	sys-apps/dbus
	sys-apps/util-linux
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:3
	x11-libs/libdrm
	x11-libs/libX11
	x11-libs/libXScrnSaver
	x11-libs/libxkbcommon
	x11-libs/libxcb
	x11-libs/libXcomposite
	x11-libs/libXcursor
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXi
	x11-libs/libXrandr
	x11-libs/libXrender
	x11-libs/libXtst
	x11-libs/pango
"

QA_PREBUILT="
	opt/discord-canary/${MY_BIN}
	opt/discord-canary/chrome_crashpad_handler
	opt/discord-canary/chrome-sandbox
	opt/discord-canary/libffmpeg.so
	opt/discord-canary/libvk_swiftshader.so
	opt/discord-canary/libvulkan.so
	opt/discord-canary/libvulkan.so.1
	opt/discord-canary/libEGL.so
	opt/discord-canary/libGLESv2.so
	opt/discord-canary/libVkICD_mock_icd.so
	opt/discord-canary/swiftshader/libEGL.so
	opt/discord-canary/swiftshader/libGLESv2.so
	opt/discord-canary/swiftshader/libvk_swiftshader.so
"

CONFIG_CHECK="~USER_NS"

src_prepare() {
	default

	sed -i \
		-e "s:/usr/share/${MY_PN}/${MY_BIN}:/opt/${MY_PN}/${MY_BIN}:g" \
		usr/share/${MY_PN}/${MY_PN}.desktop || die
}

src_install() {
	newicon usr/share/${MY_PN}/${MY_PN//-canary/}.png ${MY_PN}.png
	domenu usr/share/${MY_PN}/${MY_PN}.desktop

	insinto /opt/${MY_PN}
	doins -r usr/share/${MY_PN}/.
	fperms +x /opt/${MY_PN}/${MY_BIN}
	dosym ../../opt/${MY_PN}/${MY_BIN} usr/bin/${MY_PN}

	pax-mark -m "${ED}"/opt/${MY_PN}/${MY_PN}
}
