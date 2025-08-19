# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
CHROMIUM_LANGS="cs de en-US es fr it ja kk pt-BR pt-PT ru tr uk uz zh-CN zh-TW"
inherit chromium-2 unpacker desktop wrapper pax-utils xdg

MY_PV="${PV/_p/-}"
if [[ ${PN} == yandex-browser ]]; then
	MY_PN=${PN}-stable
else
	MY_PN=${PN}
fi

FFMPEG="135"

DESCRIPTION="The web browser from Yandex"
HOMEPAGE="https://browser.yandex.ru/"
SRC_URI="
	amd64? ( https://repo.yandex.ru/yandex-browser/deb/pool/main/y/${MY_PN}/${MY_PN}_${MY_PV}_amd64.deb -> ${P}.deb )
"

S="${WORKDIR}"

LICENSE="Yandex-EULA"
SLOT="0"
KEYWORDS="~amd64"

IUSE="+ffmpeg-codecs qt6"
RESTRICT="bindist mirror strip"

RDEPEND="
	app-accessibility/at-spi2-core
	dev-libs/expat
	dev-libs/glib:2
	dev-libs/nspr
	dev-libs/nss
	>=dev-libs/openssl-1.0.1:0
	media-libs/alsa-lib
	media-libs/fontconfig
	media-libs/freetype
	net-misc/curl
	net-print/cups
	sys-apps/dbus
	sys-libs/libcap
	sys-libs/libudev-compat
	virtual/libudev
	x11-libs/cairo
	x11-libs/libdrm
	x11-libs/libX11
	x11-libs/libxcb
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libxkbcommon
	x11-libs/libXrandr
	x11-libs/pango[X]
	x11-misc/xdg-utils
	ffmpeg-codecs? ( media-video/ffmpeg-chromium:${FFMPEG} )
	qt6? ( dev-qt/qtbase:6[gui,widgets] )
"
DEPEND="
	>=dev-util/patchelf-0.9
"

QA_PREBUILT="*"
QA_DESKTOP_FILE="usr/share/applications/yandex-browser.*\\.desktop"
YANDEX_HOME="opt/${PN/-//}"

pkg_setup() {
	chromium_suid_sandbox_check_kernel_config
}

src_unpack() {
	unpack_deb ${A}
}

src_prepare() {
	rm "usr/bin/${MY_PN}" || die "Failed to remove bundled wrapper"

	rm -r etc || die "Failed to remove etc"

	rm -r "${YANDEX_HOME}/cron" || die "Failed ro remove cron hook"

	mv usr/share/doc/${MY_PN} usr/share/doc/${PF} || die "Failed to move docdir"

	gunzip "usr/share/doc/${PF}/changelog.gz" "usr/share/man/man1/${MY_PN}.1.gz" || die "Failed to decompress docs"
	rm "usr/share/man/man1/${PN}.1.gz" || die

	pushd "${YANDEX_HOME}/locales" > /dev/null || die
	chromium_remove_language_paks
	popd > /dev/null || die

	default

	sed -r \
		-e 's|\[(NewWindow)|\[X-\1|g' \
		-e 's|\[(NewIncognito)|\[X-\1|g' \
		-e 's|^TargetEnvironment|X-&|g' \
		-e 's|-stable||g' \
		-i usr/share/applications/${PN}.desktop || die

	patchelf --remove-rpath "${S}/${YANDEX_HOME}/yandex_browser-sandbox" || die "Failed to fix library rpath (sandbox)"
	patchelf --remove-rpath "${S}/${YANDEX_HOME}/yandex_browser" || die "Failed to fix library rpath (yandex_browser)"
	patchelf --remove-rpath "${S}/${YANDEX_HOME}/find_ffmpeg" || die "Failed to fix library rpath (find_ffmpeg)"
}

src_install() {
	mv * "${D}" || die
	dodir /usr/$(get_libdir)/${MY_PN}/lib
	mv "${D}"/usr/share/appdata "${D}"/usr/share/metainfo || die

	make_wrapper "${PN}" "./${PN}" "/${YANDEX_HOME}" "/usr/$(get_libdir)/${MY_PN}/lib" || die "Failed to make wrapper"

	dosym "../../../usr/$(get_libdir)/chromium/libffmpeg.so.${FFMPEG}" "${YANDEX_HOME}/libffmpeg.so"

	# yandex_browser binary loads libudev.so.0 at runtime

	for icon in "${D}/${YANDEX_HOME}/product_logo_"*.png; do
		size="${icon##*/product_logo_}"
		size=${size%.png}
		dodir "/usr/share/icons/hicolor/${size}x${size}/apps"
		newicon -s "${size}" "$icon" "${MY_PN}.png"
	done

	rm "${ED}/${YANDEX_HOME}/libqt5_shim.so" || die
	if ! use qt6; then
		rm "${ED}/${YANDEX_HOME}/libqt6_shim.so" || die
	fi

	fowners root:root "/${YANDEX_HOME}/yandex_browser-sandbox"
	fperms 4711 "/${YANDEX_HOME}/yandex_browser-sandbox"
	pax-mark m "${ED}${YANDEX_HOME}/yandex_browser-sandbox"
}
