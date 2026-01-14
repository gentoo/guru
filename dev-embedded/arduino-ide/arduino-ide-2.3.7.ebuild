# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop xdg

DESCRIPTION="Arduino IDE 2.x - A modern open-source IDE for Arduino development"
HOMEPAGE="https://www.arduino.cc/en/software https://github.com/arduino/arduino-ide"

SRC_URI="https://github.com/arduino/arduino-ide/releases/download/${PV}/arduino-ide_${PV}_Linux_64bit.zip"
S="${WORKDIR}"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="-* ~amd64"
IUSE="egl wayland"
RESTRICT="mirror strip bindist"

RDEPEND="
	|| (
		sys-apps/systemd
		sys-apps/systemd-utils
	)
	>=app-accessibility/at-spi2-core-2.46.0:2
	app-crypt/libsecret[crypt]
	app-misc/ca-certificates
	dev-libs/expat
	dev-libs/glib:2
	dev-libs/nspr
	dev-libs/nss
	media-libs/alsa-lib
	media-libs/libglvnd
	media-libs/mesa
	net-misc/curl
	sys-apps/dbus
	virtual/zlib
	sys-process/lsof
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
	x11-libs/libXScrnSaver
	x11-libs/pango
	x11-misc/xdg-utils
"

BDEPEND="app-arch/unzip"

QA_PREBUILT="*"

src_install() {
	# Install application files
	mkdir -p "${ED}/opt/${PN}" || die
	cp -r "${S}/arduino-ide_${PV}_Linux_64bit/"* "${ED}/opt/${PN}" || die

	# Fix chrome-sandbox permissions
	fperms 4755 /opt/${PN}/chrome-sandbox

	# Create symlink for the main executable
	dosym ../../opt/${PN}/arduino-ide /usr/bin/arduino-ide

	# Build exec flags based on USE flags
	local EXEC_EXTRA_FLAGS=()
	if use wayland; then
		EXEC_EXTRA_FLAGS+=( "--ozone-platform-hint=auto" "--enable-wayland-ime" "--wayland-text-input-version=3" )
	fi
	if use egl; then
		EXEC_EXTRA_FLAGS+=( "--use-gl=egl" )
	fi

	# Install desktop file with proper exec flags
	sed "s|@exec_extra_flags@|${EXEC_EXTRA_FLAGS[*]}|g" \
		"${FILESDIR}/${PN}.desktop" \
		> "${T}/${PN}.desktop" || die
	domenu "${T}/${PN}.desktop"

	# Install icon
	newicon "${ED}/opt/${PN}/resources/app/resources/icons/512x512.png" "${PN}.png"
}

pkg_postinst() {
	xdg_pkg_postinst
	elog "Arduino IDE 2.x has been installed to /opt/${PN}"
	elog "You can start it by running 'arduino-ide' from the command line"
	elog "or by selecting it from your application menu."
	elog ""
	elog "Note: Arduino IDE 2.x is a completely new application based on"
	elog "Eclipse Theia, and can coexist with the classic Arduino IDE 1.x."
}
