# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CHROMIUM_LANGS="
	af am ar bg bn ca cs da de el en-GB en-US es es-419 et fa fi fil fr gu he hi
	hr hu id it ja kn ko lt lv ml mr ms nb nl pl pt-BR pt-PT ro ru sk sl sr sv
	sw ta te th tr uk ur vi zh-CN zh-TW
"

inherit chromium-2 desktop xdg

APPIMAGE="Logic-${PV}-linux-x64.AppImage"
DESCRIPTION="Saleae logic analyzer"
HOMEPAGE="https://www.saleae.com"

SRC_URI="https://downloads2.saleae.com/logic2/${APPIMAGE}"

S="${WORKDIR}"
LICENSE="Saleae"
SLOT="0"
KEYWORDS="-* ~amd64"

RESTRICT="bindist mirror strip"

RDEPEND="
	app-accessibility/at-spi2-core:2
	dev-libs/dbus-glib
	dev-libs/expat
	dev-libs/glib:2
	dev-libs/libdbusmenu
	dev-libs/nspr
	dev-libs/nss
	media-libs/alsa-lib
	media-libs/mesa
	net-print/cups
	sys-apps/dbus
	sys-libs/libxcrypt
	sys-libs/zlib
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:2
	x11-libs/gtk+:3
	x11-libs/libnotify
	x11-libs/libX11
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXrandr
	x11-libs/libXScrnSaver
	x11-libs/libXtst
	x11-libs/libdrm
	x11-libs/libxcb
	x11-libs/libxkbcommon
	x11-libs/pango
"

BDEPEND="dev-util/patchelf"

QA_PREBUILT="*"

src_unpack() {
	cp "${DISTDIR}/${APPIMAGE}" "${S}" || die

	cd "${S}" || die # "appimage-extract" unpacks to current directory
	chmod +x "${APPIMAGE}" || die
	./"${APPIMAGE}" --appimage-extract || die
}

src_prepare() {
	# Fix permissions
	find "${S}" -type d -exec chmod a+rx {} + || die
	find "${S}" -type f -exec chmod a+r {} + || die

	cd squashfs-root || die

	for f in *.so; do
		patchelf --set-rpath '$ORIGIN' $f || die
	done

	# scanelf: rpath_security_checks(): Security problem NULL DT_RUNPATH
	pushd resources/linux-x64/Analyzers || die
	for f in *.so; do
		patchelf --set-rpath '$ORIGIN' $f || die
	done
	popd

	pushd locales || die
	chromium_remove_language_paks
	popd

	default
}

src_configure() {
	default
	chromium_suid_sandbox_check_kernel_config
}

src_install() {
	cd "${S}/squashfs-root" || die

	insinto /usr/share
	doins -r ./usr/share/icons

	local -a toremove=(
		.DirIcon
		AppRun
		Logic.png
		usr/lib/libnotify.so.4
		usr/lib/libXss.so.1
		usr/lib/libXtst.so.6
	)
	rm -r "${toremove[@]}" || die

	insinto /opt/Logic
	doins -r *

	fperms 4755 /opt/Logic/chrome-sandbox
	for i in Logic chrome_crashpad_handler *.so* usr/lib/*.so*; do
		fperms +x "/opt/Logic/${i}"
	done

	dosym -r "/opt/Logic/Logic" /usr/bin/Logic
	domenu Logic.desktop
}
