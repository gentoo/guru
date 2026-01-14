# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop xdg

MY_PN="OrcaSlicer"

DESCRIPTION="G-code generator for 3D printers (Bambu, Prusa, Voron, Creality)"
HOMEPAGE="https://github.com/OrcaSlicer/OrcaSlicer"
SRC_URI="https://github.com/OrcaSlicer/OrcaSlicer/releases/download/v${PV}/${MY_PN}_Linux_AppImage_Ubuntu2404_V${PV}.AppImage -> ${P}.AppImage"
S="${WORKDIR}"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="-* ~amd64"
RESTRICT="mirror strip bindist"

# AppImage bundles most dependencies, but we need basic system libs
RDEPEND="
	dev-libs/glib:2
	media-libs/libglvnd
	media-libs/mesa
	sys-apps/dbus
	virtual/zlib
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:3
	x11-libs/libX11
	x11-libs/libxcb
	x11-libs/libxkbcommon
	x11-libs/pango
"

BDEPEND="dev-util/patchelf"

QA_PREBUILT="*"

src_unpack() {
	cp "${DISTDIR}/${P}.AppImage" "${WORKDIR}/" || die
	chmod +x "${WORKDIR}/${P}.AppImage" || die
	"${WORKDIR}/${P}.AppImage" --appimage-extract || die "Failed to extract AppImage"
	mv squashfs-root "${MY_PN}" || die
}

src_install() {
	# Fix RUNPATH security issue
	patchelf --set-rpath '$ORIGIN' "${S}/${MY_PN}/bin/orca-slicer" || die

	# Install application files
	insinto /opt/${PN}
	doins -r "${MY_PN}"/*

	# Make binaries executable
	fperms +x /opt/${PN}/AppRun
	fperms +x /opt/${PN}/bin/orca-slicer

	# Find and make all .so files executable
	find "${ED}/opt/${PN}" -name "*.so*" -exec chmod +x {} \;

	# Create symlink to launcher
	dosym ../../opt/${PN}/AppRun /usr/bin/orca-slicer

	# Install desktop file and icon
	newicon "${S}/${MY_PN}/OrcaSlicer.png" orca-slicer.png
	make_desktop_entry "orca-slicer %F" "OrcaSlicer" "orca-slicer" "Graphics;3DGraphics;Engineering;" \
		"MimeType=model/stl;application/vnd.ms-3mfdocument;application/prs.wavefront-obj;application/x-amf;"
}

pkg_postinst() {
	xdg_pkg_postinst
	elog "OrcaSlicer has been installed to /opt/${PN}"
	elog "You can start it by running 'orca-slicer' from the command line"
	elog "or by selecting it from your application menu."
	elog ""
	elog "Wayland support is automatically detected and enabled when needed."
}
