# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop unpacker xdg

DESCRIPTION="A second brain, for you, forever."
HOMEPAGE="https://obsidian.md"
SRC_URI="https://github.com/obsidianmd/obsidian-releases/releases/download/v${PV}/${PN}_${PV}_amd64.deb"

LICENSE="Obsidian-EULA"
SLOT="0"
KEYWORDS="~amd64"

S="${WORKDIR}"

src_install() {
	insinto /opt/Obsidian
	doins -r opt/Obsidian/*

	domenu usr/share/applications/obsidian.desktop

	for size in 16 32 48 64 128 256 512; do
		doicon --size "${size}" "usr/share/icons/hicolor/${size}x${size}/apps/${PN}.png"
	done

	fperms 4755 /opt/Obsidian/chrome-sandbox || die
	fperms +x  /opt/Obsidian/obsidian || die

	dosym ../../opt/Obsidian/obsidian /usr/bin/obsidian
}
