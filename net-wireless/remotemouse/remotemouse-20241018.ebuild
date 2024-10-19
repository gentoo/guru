# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit wrapper

DESCRIPTION="Use phone as wireless mouse/touchpad (through Wi-Fi or Bluetooth), switch slides"
HOMEPAGE="http://remotemouse.net"

# No version number - I wrote them to add version to the filename
SRC_URI="https://www.remotemouse.net/downloads/linux/RemoteMouse_x86_64.zip -> ${P}.zip"

S="${WORKDIR}"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="strip mirror"

QA_PREBUILT="*"
QA_SONAME="*"

BDEPEND="
	app-arch/unzip
"

src_install() {
	insinto "/opt/${PN}"
	doins -r .

	local path="/opt/${PN}/RemoteMouse"
	fperms +x $path

	make_wrapper RemoteMouse $path
}
