# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker desktop xdg

DESCRIPTION="TETR.IO desktop client."
HOMEPAGE="https://tetr.io/"

SRC_URI="https://tetr.io/about/desktop/builds/${PV}/TETR.IO%20Setup.deb -> ${P}.deb
	tetrio-plus?	( https://gitlab.com/UniQMG/tetrio-plus/uploads/\
a7342b94f03d670b72235ab453c427a5/tetrio-plus_0.26.0_app.asar.zip -> tetrio-plus.zip )"

S="${WORKDIR}"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"

IUSE="tetrio-plus"

RESTRICT="bindist mirror test strip"

BDEPEND="
	app-arch/unzip
"
RDEPEND="
	x11-libs/gdk-pixbuf:2
	x11-libs/libXScrnSaver
	x11-libs/libXcursor
	x11-libs/libXi
	x11-libs/libXrender
	x11-libs/libXtst
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
	x11-libs/libXrandr
	x11-libs/pango
"

QA_PREBUILT=".*"

PATCHES=(
	"${FILESDIR}/${P}-application.patch"

)

src_unpack() {
	unpack_deb "${P}.deb"
	if use tetrio-plus; then
		unpack "tetrio-plus.zip"
	fi
}

src_prepare() {
	eapply ${PATCHES}
	eapply_user

	if use tetrio-plus;	then
		mv "${S}/app.asar" "${S}/opt/TETR.IO/resources/app.asar" || die
	fi

	mv "${S}/opt/TETR.IO" "${S}/opt/${PN}" || die
}

src_install() {
	ICONDIR="usr/share/icons/hicolor"
	DESTDIR="/opt/${PN}"

	doicon -s 256 "${ICONDIR}/256x256/apps/tetrio-desktop.png"
	doicon -s 512 "${ICONDIR}/512x512/apps/tetrio-desktop.png"

	domenu "usr/share/applications/tetrio-desktop.desktop"

	dodir /opt/${PN}

	exeinto "${DESTDIR}"
	doexe "opt/${PN}/tetrio-desktop" "opt/${PN}/chrome-sandbox" "opt/${PN}/libEGL.so" \
		"opt/${PN}/libffmpeg.so" "opt/${PN}/libGLESv2.so" "opt/${PN}/libvk_swiftshader.so" "opt/${PN}/libvulkan.so"

	insinto "${DESTDIR}"
	doins "opt/${PN}/chrome_100_percent.pak" "opt/${PN}/chrome_200_percent.pak" "opt/${PN}/icudtl.dat" \
		"opt/${PN}/resources.pak" "opt/${PN}/snapshot_blob.bin" "opt/${PN}/v8_context_snapshot.bin"\
		"opt/${PN}/vk_swiftshader_icd.json"

	doins -r "opt/${PN}/locales" "opt/${PN}/resources" "opt/${PN}/swiftshader"

	fperms a+x "${DESTDIR}/swiftshader/"*

	fowners root "${DESTDIR}/chrome-sandbox"
	fperms 4711 "${DESTDIR}/chrome-sandbox"

	dosym -r "/opt/${PN}/tetrio-desktop" "/usr/bin/${PN}"
}
