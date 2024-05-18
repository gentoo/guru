# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop unpacker xdg

DESCRIPTION="A cross-platform, complete password management solution"
HOMEPAGE="https://enpass.io/"
SRC_URI="https://apt.enpass.io/pool/main/e/enpass/enpass_${PV}_amd64.deb"

S="${WORKDIR}"

LICENSE="Enpass-EULA"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="bindist mirror strip"

RDEPEND="
	net-misc/curl
	sys-process/lsof
	x11-libs/libXScrnSaver
	x11-libs/libxkbcommon
"

QA_PREBUILT="/opt/enpass/*"

src_unpack() {
	unpack_deb ${A}
}

src_install() {
	insinto /
	doins -r opt
	fperms +x /opt/enpass/{Enpass,importer_enpass,wifisyncserver_bin}

	domenu usr/share/applications/enpass.desktop

	gunzip usr/share/doc/enpass/changelog.gz || die
	dodoc usr/share/doc/enpass/changelog

	for size in {16,24,32,48,64,96,128,256}; do
		doicon -s ${size} usr/share/icons/hicolor/${size}x${size}/apps/enpass.png
	done

	for size in {16,22,24,32,48}; do
		doicon -s ${size} usr/share/icons/hicolor/${size}x${size}/status/enpass-status.png
		doicon -s ${size} usr/share/icons/hicolor/${size}x${size}/status/enpass-status-dark.png
	done

	insinto /usr/share/mime/packages
	doins usr/share/mime/packages/application-enpass.xml
}
