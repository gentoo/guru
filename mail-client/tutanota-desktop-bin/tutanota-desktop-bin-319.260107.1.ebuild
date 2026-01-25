# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop xdg

DESCRIPTION="Desktop client for Tutanota, the secure e-mail service"
HOMEPAGE="https://tuta.com/secure-email"
SRC_URI="
	https://app.tuta.com/desktop/tutanota-desktop-linux.AppImage -> ${P}.AppImage
	https://app.tuta.com/desktop/linux-sig.bin -> ${P}-sig.bin
	https://github.com/tutao/tutanota/raw/tutanota-desktop-release-${PV}/tutao-pub.pem -> ${P}-tutao-pub.pem
"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="bindist mirror strip"

RDEPEND="
	app-accessibility/at-spi2-core:2
	app-crypt/libsecret
	dev-libs/expat
	dev-libs/glib:2
	dev-libs/nspr
	dev-libs/nss
	media-libs/alsa-lib
	media-libs/mesa
	net-print/cups
	sys-apps/dbus
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:3
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

BDEPEND="dev-libs/openssl"

S="${WORKDIR}"

QA_PREBUILT="opt/tutanota-desktop/*"

src_unpack() {
	cp "${DISTDIR}/${P}.AppImage" "${WORKDIR}/" || die "Failed to copy AppImage"
	chmod +x "${P}.AppImage" || die "Failed to make AppImage executable"

	einfo "Verifying AppImage signature..."
	openssl dgst -sha512 \
		-verify "${DISTDIR}/${P}-tutao-pub.pem" \
		-signature "${DISTDIR}/${P}-sig.bin" \
		"${P}.AppImage" || die "Signature verification failed"

	einfo "Extracting AppImage..."
	./"${P}.AppImage" --appimage-extract >/dev/null || die "Failed to extract AppImage"
}

src_prepare() {
	default

	sed -i \
		-e "s|^Exec=.*|Exec=/opt/tutanota-desktop/tutanota-desktop %U|" \
		-e "/^X-AppImage-Version=/d" \
		-e "/^X-Desktop-File-Install-Version=/d" \
		squashfs-root/tutanota-desktop.desktop || die "Failed to fix desktop file"
}

src_install() {
	local install_dir="/opt/tutanota-desktop"

	insinto "${install_dir}"
	doins -r squashfs-root/.

	fperms +x "${install_dir}/tutanota-desktop"
	fperms +x "${install_dir}/chrome_crashpad_handler"
	fperms 4755 "${install_dir}/chrome-sandbox"

	rm -rf "${ED}${install_dir}"/{AppRun,usr,tutanota-desktop.desktop,*.png} || die

	dosym "${optdir}/tutanota-desktop" /usr/bin/tutanota-desktop

	domenu squashfs-root/tutanota-desktop.desktop

	local size
	for size in 16 24 32 48 64 128 256 512; do
		if [[ -f squashfs-root/usr/share/icons/hicolor/${size}x${size}/apps/tutanota-desktop.png ]]; then
			newicon -s ${size} \
				squashfs-root/usr/share/icons/hicolor/${size}x${size}/apps/tutanota-desktop.png \
				tutanota-desktop.png
		fi
	done
}

pkg_postinst() {
	xdg_pkg_postinst
}

pkg_postrm() {
	xdg_pkg_postrm
}
