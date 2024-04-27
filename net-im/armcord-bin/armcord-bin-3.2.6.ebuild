# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker desktop xdg

DESCRIPTION="ArmCord is a custom client designed to enhance your Discord experience."
HOMEPAGE="https://armcord.app/"
SRC_URI="https://github.com/ArmCord/ArmCord/releases/download/v${PV}/ArmCord_${PV}_amd64.deb -> ${P}.deb"
S="${WORKDIR}"

LICENSE="MIT BSD OSL-3.0"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="bindist mirror test strip"

RDEPEND="
	app-accessibility/at-spi2-core:2
	dev-libs/expat
	dev-libs/glib:2
	dev-libs/nspr
	dev-libs/nss
	media-libs/alsa-lib
	media-libs/mesa
	net-print/cups
	sys-apps/dbus
	x11-libs/cairo
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
	x11-libs/pango
"
QA_PREBUILT=".*"

PATCHES=(
	"${FILESDIR}/${PN}-desktop.patch"
)

src_unpack() {
	unpack_deb "${P}.deb"
}

src_prepare() {
	default

	mv "${WORKDIR}/opt/ArmCord" "${WORKDIR}/opt/${PN}" || die
	mv "${WORKDIR}/usr/share/applications/armcord.desktop" "${WORKDIR}/${PN}.desktop" || die
	mv "${WORKDIR}"/usr/share/icons/hicolor/* "${WORKDIR}/" || die
	rm -rf "${WORKDIR}/usr/share/doc" || die
}

src_install() {
	DESTDIR="/opt/${PN}"

	doicon -s 16 "16x16/apps/armcord.png"
	doicon -s 32 "32x32/apps/armcord.png"
	doicon -s 48 "48x48/apps/armcord.png"
	doicon -s 64 "64x64/apps/armcord.png"
	doicon -s 128 "128x128/apps/armcord.png"
	doicon -s 256 "256x256/apps/armcord.png"
	doicon -s 512 "512x512/apps/armcord.png"
	doicon -s 1024 "1024x1024/apps/armcord.png"

	domenu "${PN}.desktop"

	exeinto "${DESTDIR}"
	doexe "opt/${PN}/armcord" "opt/${PN}/chrome-sandbox" "opt/${PN}/libEGL.so" \
	"opt/${PN}/libffmpeg.so" "opt/${PN}/libGLESv2.so" "opt/${PN}/libvk_swiftshader.so"

	insinto "${DESTDIR}"
	doins "opt/${PN}/chrome_100_percent.pak" "opt/${PN}/chrome_200_percent.pak" "opt/${PN}/icudtl.dat" \
	"opt/${PN}/resources.pak" "opt/${PN}/snapshot_blob.bin" "opt/${PN}/v8_context_snapshot.bin"
	insopts -m0766
	doins -r "opt/${PN}/locales" "opt/${PN}/resources"

	fperms -R 644 "${DESTDIR}/locales"
	fperms -R 644 "${DESTDIR}/resources"

	# Fix bug 930639
	fperms -R a+r "${DESTDIR}"/resources/
	fperms a+x "${DESTDIR}"/resources/

	fowners root "${DESTDIR}/chrome-sandbox"
	fperms 4711 "${DESTDIR}/chrome-sandbox"

	doins "opt/${PN}/chrome_crashpad_handler"
	fperms 755 "${DESTDIR}/chrome_crashpad_handler"

	dosym -r /opt/${PN}/armcord /usr/bin/${PN}
}
