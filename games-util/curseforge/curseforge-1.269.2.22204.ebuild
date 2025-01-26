# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop

DESCRIPTION="The CurseForge Electron App"
HOMEPAGE="https://www.curseforge.com/"
SRC_URI="https://curseforge.overwolf.com/downloads/curseforge-latest-linux.zip"
S="${WORKDIR}/build"

LICENSE="Overwolf MIT Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="bindist mirror strip test"

RDEPEND="
	sys-fs/fuse:0
"
DEPEND=${RDEPEND}
BDEPEND="
	app-arch/unzip
"

DESTDIR="/opt/${PN}"

src_install() {
	mv ./CurseForge-*.AppImage CurseForge.AppImage
	chmod +x CurseForge.AppImage
	./CurseForge.AppImage --appimage-extract >/dev/null
	sed -i 's/Exec=.*/Exec=\/usr\/bin\/curseforge %U/' squashfs-root/curseforge.desktop

	doicon -s 256 squashfs-root/curseforge.png
	domenu squashfs-root/curseforge.desktop

	exeinto "${DESTDIR}"
	doexe CurseForge.AppImage "${FILESDIR}/curseforge"

	dosym "${DESTDIR}/curseforge" "/usr/bin/curseforge"
}

pkg_postinst() {
	elog "This package is an AppImage that will keep itself up-to-date."
	elog "Older versions cannot be saved since only the latest version"
	elog "is available upstream. Fuse is required as of Version 1.269.2-22204"
	elog "because the AppImage is the only way to start the App. May change in"
	elog "the future. CurseForge is not open-source."
}
