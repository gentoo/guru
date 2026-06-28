# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit desktop
DESCRIPTION="OmenCore is an Advanced Performance Control for HP Omen Laptops"
HOMEPAGE="https://omencore.info/"
SRC_URI="https://github.com/theantipopau/omencore/releases/download/v${PV}/OmenCore-${PV}-linux-x64.zip"
S="${WORKDIR}" #src unzip /work directory
LICENSE="MIT"
SLOT="0"
KEYWORDS="-* ~amd64"
RESTRICT="mirror strip"
QA_PREBUILT="*"
BDEPEND="app-arch/unzip"
RDEOEND="x11-libs/libSM
		x11-libs/libX11
		x11-libs/libXext
		x11-libs/libXrandr
		x11-libs/libXi"
src_install() {
	insinto /opt/omencore-bin
	doins -r *
	fperms 755 /opt/omencore-bin/omencore-cli
	fperms 755 /opt/omencore-bin/omencore-gui
	dosym -r /opt/omencore-bin/omencore-cli /usr/bin/omencore-cli
	dosym -r /opt/omencore-bin/omencore-gui /usr/bin/omencore-gui
	make_desktop_entry "omencore-gui" "OmenCore" "preferences-system" "System;HardwareSettings;"
}
