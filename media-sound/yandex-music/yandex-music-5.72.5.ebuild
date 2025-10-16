# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
CHROMIUM_LANGS="af am ar bg bn ca cs da de el en-GB en-US es-419 es et fa fi fil fr gu he hi hr hu id it ja kn ko \
lt lv ml mr ms nb nl pl pt-BR pt-PT ro ru sk sl sr sv sw ta te th tr uk ur vi zh-CN zh-TW"
inherit chromium-2 pax-utils wrapper unpacker xdg

MY_PN="Yandex_Music"

DESCRIPTION="Yandex Music streaming service"
HOMEPAGE="https://music.yandex.ru/"
SRC_URI="
	amd64? ( https://music-desktop-application.s3.yandex.net/stable/Yandex_Music_amd64_${PV}.deb )
"

S="${WORKDIR}"

LICENSE="Yandex-EULA"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="bindist mirror strip"

RDEPEND="
	app-accessibility/at-spi2-core
	app-arch/bzip2
	dev-libs/expat
	dev-libs/fribidi
	dev-libs/glib:2
	dev-libs/gmp
	dev-libs/libffi
	dev-libs/libpcre2
	dev-libs/libtasn1
	dev-libs/libunistring
	dev-libs/nettle
	dev-libs/nspr
	dev-libs/nss
	dev-libs/wayland
	media-gfx/graphite2
	media-libs/alsa-lib
	media-libs/fontconfig
	media-libs/freetype
	media-libs/harfbuzz
	media-libs/libepoxy
	media-libs/libjpeg-turbo
	media-libs/libpng
	media-libs/mesa
	net-dns/libidn2
	net-libs/gnutls
	net-print/cups
	sys-apps/dbus
	sys-apps/systemd-utils
	sys-apps/util-linux
	sys-devel/gcc
	sys-libs/glibc
	sys-libs/libcap
	sys-libs/zlib
	x11-libs/cairo[X,glib]
	x11-libs/gdk-pixbuf
	x11-libs/gtk+
	x11-libs/libX11
	x11-libs/libXau
	x11-libs/libXcomposite
	x11-libs/libXcursor
	x11-libs/libXdamage
	x11-libs/libXdmcp
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXi
	x11-libs/libXrandr
	x11-libs/libXrender
	x11-libs/libdrm
	x11-libs/libxcb
	x11-libs/libxkbcommon
	x11-libs/pango[X]
	x11-libs/pixman
"
DEPEND="
	>=dev-util/patchelf-0.9
"

QA_PREBUILT="*"
QA_DESKTOP_FILE="usr/share/applications/yandex-music.*\\.desktop"
YANDEX_HOME="opt/${PN}"

pkg_setup() {
	chromium_suid_sandbox_check_kernel_config
}

src_unpack() {
	unpack_deb ${A}
	mv -T "${S}/opt/Яндекс Музыка" "${S}/opt/${PN}" || die
	mv -T "${S}/usr/share/doc/yandexmusic" "${S}/usr/share/doc/${PF}" || die
}

src_prepare() {
	default
	sed -i -e "s|/opt/Яндекс Музыка/yandexmusic|/opt/bin/${PN}|" -i -e "s/Audio;/AudioVideo;/" \
		"${S}"/usr/share/applications/yandexmusic.desktop || die

	sed -i -e "s|/opt/Яндекс Музыка|/opt/${PN}|" "${S}/opt/${PN}"/resources/apparmor-profile || die

	gunzip "usr/share/doc/${PF}/changelog.gz" || die "Failed to decompress docs"

	rm "${S}/opt/${PN}"/resources/app-update.yml || die

	pushd "${YANDEX_HOME}/locales" > /dev/null || die
	chromium_remove_language_paks
	popd > /dev/null || die

	patchelf --remove-rpath "${S}/${YANDEX_HOME}/chrome-sandbox" || die "Failed to fix library rpath (chrome-sandbox)"
	patchelf --remove-rpath "${S}/${YANDEX_HOME}/yandexmusic" || die "Failed to fix library rpath (yandexmusic)"
}

src_install() {
	insinto /opt
	doins -r opt/*

	insinto /usr
	doins -r usr/*

	make_wrapper ${PN} "/opt/${PN}/${PN/-/}" "" "/opt/${PN}" "/opt/bin/"

	fowners root:root "/${YANDEX_HOME}/yandexmusic"
	fperms 4711 "/${YANDEX_HOME}/chrome-sandbox"
	pax-mark m "${ED}${YANDEX_HOME}/chrome-sandbox"
	fperms 755 /opt/"${PN}"/yandexmusic
}
