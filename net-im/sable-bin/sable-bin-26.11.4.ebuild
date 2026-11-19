# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker desktop xdg

DESCRIPTION="Sable, a Matrix client"
HOMEPAGE="https://sable.moe"
SRC_URI="
	amd64? (
		https://git.sable.moe/SableClient/sable-next/releases/download/v${PV}/sable-${PV}-amd64.deb
	)
	arm64? (
		https://git.sable.moe/SableClient/sable-next/releases/download/v${PV}/sable-${PV}-arm64.deb
	)
"

S="${WORKDIR}"
LICENSE="AGPL-3+"
SLOT="0"
KEYWORDS="-* ~amd64 ~arm64"
RESTRICT="strip"

RDEPEND="
	app-accessibility/at-spi2-core:2
	dev-libs/nss
	dev-util/desktop-file-utils
	media-libs/alsa-lib
	media-libs/mesa
	net-print/cups
	sys-apps/util-linux
	x11-libs/gtk+:3
	x11-libs/libXScrnSaver
	x11-libs/libXtst
	x11-libs/libdrm
	x11-libs/libnotify
	x11-libs/libxkbcommon
	x11-misc/xdg-utils
	x11-themes/hicolor-icon-theme
"

DESTDIR="/opt/${PN}"
QA_PREBUILT="opt/Sable/*"

src_install() {

	rm -f opt/Sable/resources/app-update.yml || die
	echo 'gentoo::guru' > opt/Sable/resources/package-type || die

	local opt_path="opt/Sable"
	find . -type f -print0 | xargs --null sed -i "s|/${opt_path}|${DESTDIR}|gI" || die
	find "${opt_path}" | while IFS='' read -r line; do
		dir_name="$(dirname "${line}")"
		dir_name="${DESTDIR}/${dir_name##"${opt_path}"}"
		if [[ ! -d "${line}" && -x "${line}" ]]; then
			exeinto "${dir_name}"
			doexe "${line}"
		elif [[ ! -s "${line}" && -d "${line}" ]]; then
			insinto "${dir_name}"
			doins -r "${line}"
		elif [[ ! -d "${line}" ]]; then
			insinto "${dir_name}"
			doins "${line}"
		fi
	done

	domenu usr/share/applications/moe.sable.client.desktop
	gzip --decompress usr/share/doc/sable/changelog.gz
	dodoc usr/share/doc/sable/changelog
	doicon -s 512x512 usr/share/icons/hicolor/512x512/apps/sable.png
}
