# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CHROMIUM_LANGS="af am ar bg bn ca cs da de el en-GB en-US es-419 es
	et fa fi fil fr gu he hi hr hu id it ja kn ko lt lv ml mr ms nb nl
	pl pt-BR pt-PT ro ru sk sl sr sv sw ta te th tr uk ur vi zh-CN zh-TW"

inherit chromium-2 desktop pax-utils xdg

DESCRIPTION="Private, fast, and honest web browser based on Chromium"
HOMEPAGE="https://helium.computer/"

MY_PN="helium"
MY_P="${MY_PN}-${PV}"

if [[ ${ARCH} == amd64 ]] ; then
	ARCH_TXT="x86_64"
elif [[ ${ARCH} == arm64 ]] ; then
	ARCH_TXT="${ARCH}"
fi

SRC_URI="
amd64? ( https://github.com/imputnet/${MY_PN}-linux/releases/download/${PV}/${MY_P}-x86_64_linux.tar.xz -> ${P}-amd64.tar.xz )
arm64? ( https://github.com/imputnet/${MY_PN}-linux/releases/download/${PV}/${MY_P}-arm64_linux.tar.xz -> ${P}-arm64.tar.xz )
"

S=${WORKDIR}

LICENSE="GPL-3 BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

IUSE="qt6 selinux"

RESTRICT="bindist mirror strip"

RDEPEND="
	>=app-accessibility/at-spi2-core-2.46.0:2
	app-misc/ca-certificates
	dev-libs/expat
	dev-libs/glib:2
	dev-libs/nspr
	>=dev-libs/nss-3.26
	media-fonts/liberation-fonts
	media-libs/alsa-lib
	media-libs/mesa[gbm(+)]
	net-misc/curl
	net-print/cups
	sys-apps/dbus
	sys-libs/glibc
	sys-libs/libcap
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2
	|| (
		x11-libs/gtk+:3[X]
		gui-libs/gtk:4[X]
	)
	x11-libs/libdrm
	>=x11-libs/libX11-1.5.0
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXrandr
	x11-libs/libxcb
	x11-libs/libxkbcommon
	x11-libs/libxshmfence
	x11-libs/pango
	x11-misc/xdg-utils
	qt6? ( dev-qt/qtbase:6[gui,widgets] )
	selinux? ( sec-policy/selinux-chromium )
"

QA_PREBUILT="*"

pkg_setup() {
	chromium_suid_sandbox_check_kernel_config
}

# Skip unpack, we're doing it during install
src_unpack() {
	:
}

src_install() {
	dodir "opt" || die
	cd "${ED}/opt/" || die

	# Not possible to unpack to target folder, so: unpack, then mv
	unpack "${P}-${ARCH}.tar.xz"
	mv ${MY_P}-${ARCH_TXT}_linux ${MY_PN} || die

	cd "${MY_PN}" || die

	pushd "locales" > /dev/null || die
	# Remove empty .info files
	rm *.info || die
	chromium_remove_language_paks
	popd > /dev/null || die

	rm "libqt5_shim.so" || die
	if ! use qt6; then
		rm "libqt6_shim.so" || die
	fi

	newicon -s 256 "product_logo_256.png" ${MY_PN}.png
	domenu "${FILESDIR}/${MY_PN}.desktop"
	dobin "${FILESDIR}/${MY_PN}"

	pax-mark m "${MY_PN}"
}
