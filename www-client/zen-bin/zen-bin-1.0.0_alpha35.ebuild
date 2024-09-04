# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit xdg-utils desktop

MY_PV="1.0.0-a.35"
MY_P="zen"

DESCRIPTION="Zen Browser - A Firefox-based browser focused on privacy"
HOMEPAGE="https://github.com/zen-browser/desktop"
SRC_URI="https://github.com/zen-browser/desktop/releases/download/${MY_PV}/${MY_P}.linux-specific.tar.bz2 -> ${P}.tar.bz2"

S="${WORKDIR}"
LICENSE="MPL-2.0"
SLOT="0"

RDEPEND="
	dev-libs/expat
	dev-libs/glib:2
	dev-libs/nspr
	dev-libs/nss
	media-libs/alsa-lib
	media-libs/fontconfig
	media-libs/freetype
	media-libs/mesa
	net-print/cups
	sys-apps/dbus
	sys-libs/glibc
	x11-libs/cairo
	x11-libs/gdk-pixbuf
	x11-libs/gtk+:3
	x11-libs/libX11
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

DEPEND="${RDEPEND}"

QA_PREBUILT="opt/zen/*"

src_install() {
	#create dest dir
	local destdir="/opt/zen"
	dodir "${destdir}"
	#copy files into dest dir
	cp -a "${S}/zen"/* "${ED}${destdir}" || die
	#create a symlink to the binary
	dosym "${destdir}/zen-bin" "/usr/bin/zen-bin" || die
	#add icons
	local icon_dir="${ED}${destdir}/browser/chrome/icons/default"
	if [[ -d "${icon_dir}" ]]; then
		for size in 16 32 48 64 128; do
			if [[ -f "${icon_dir}/default${size}.png" ]]; then
				newicon -s ${size} "${icon_dir}/default${size}.png" zen.png
			fi
		done
	else
		ewarn "Icon directory not found, skipping icon installation"
	fi
	#create desktop file
	make_desktop_entry zen-bin "Zen" zen "Network;WebBrowser"
	#handle permissions of destdir files
	fperms 0755 "${destdir}"/{zen-bin,updater,glxtest,vaapitest}
	fperms 0750 "${destdir}"/pingsender
}

pkg_postinst() {
	xdg_icon_cache_update
	xdg_desktop_database_update
	elog "For optimal performance and compatibility, please ensure"
	elog "that you have the latest graphics drivers installed."
}

pkg_postrm() {
	xdg_icon_cache_update
	xdg_desktop_database_update
}
