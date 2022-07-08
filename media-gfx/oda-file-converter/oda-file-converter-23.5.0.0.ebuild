# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PV="$(ver_cut 1-2)"

inherit desktop unpacker xdg

DESCRIPTION="For converting between different versions of .dwg and .dxf"
HOMEPAGE="https://www.opendesign.com"

SRC_URI="https://download.opendesign.com/guestfiles/Demo/ODAFileConverter_QT5_lnxX64_8.3dll_${MY_PV}.deb"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="-* ~amd64"

RDEPEND="
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	x11-themes/hicolor-icon-theme
"

DEPEND="${RDEPEND}"

BDEPEND="dev-util/patchelf"

S="${WORKDIR}"

QA_PREBUILT="*"
QA_DESKTOP_FILE="usr/share/applications/ODAFileConverter.*\\.desktop"

src_compile() {
	patchelf --set-rpath \
		"/usr/bin/ODAFileConverter_${PV}" \
		"usr/bin/ODAFileConverter_${PV}/ODAFileConverter" \
		|| die "Failed to fix insecure RPATH"
	rm -rf usr/bin/ODAFileConverter_${PV}/qt.conf || die "Failed to fix qt.conf"
}

src_install() {
	exeinto /usr/bin
	doexe usr/bin/ODAFileConverter
	exeinto /usr/bin/ODAFileConverter_${PV}
	doexe usr/bin/ODAFileConverter_${PV}/*
	domenu usr/share/applications/*.desktop
	doicon -s 16 usr/share/icons/hicolor/16x16/apps/ODAFileConverter.png
	doicon -s 32 usr/share/icons/hicolor/32x32/apps/ODAFileConverter.png
	doicon -s 64 usr/share/icons/hicolor/64x64/apps/ODAFileConverter.png
	doicon -s 128 usr/share/icons/hicolor/128x128/apps/ODAFileConverter.png
}