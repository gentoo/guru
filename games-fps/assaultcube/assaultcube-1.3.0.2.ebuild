# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop xdg-utils

DESCRIPTION="Free multiplayer FPS based on the Cube engine"
HOMEPAGE="https://assault.cubers.net/"
SRC_URI="https://github.com/assaultcube/AC/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/AC-${PV}"
LICENSE="ZLIB assaultcube"
SLOT="0"
KEYWORDS="~amd64"
RDEPEND="sys-libs/zlib media-libs/libsdl2 media-libs/sdl2-image x11-libs/libX11 media-libs/libogg media-libs/libvorbis media-libs/openal"
DEPEND="${RDEPEND}"
BDEPEND="sys-devel/clang"

src_prepare() {
	eapply_user
	sed -i 's|//#define PRODUCTION|#define PRODUCTION|' "${S}/source/src/cube.h"
	rm -rf "${S}/source/include"
}

src_compile() {
	cd "${S}/source/src"
	emake
}

src_install() {
	cd "${S}/source/src"
	emake install

	install -dm755 "${D}/usr/share/assaultcube"
	install -Dm755 "${S}"/{assaultcube.sh,check_install.sh,server.sh,server_wizard.sh} -t "${D}/usr/share/assaultcube"
	install -Dm755 "${S}/bin_unix/native_client" -t "${D}/usr/share/assaultcube/bin_unix"
	cp -r "${S}"/{bot,config,demos,docs,mods,packages} "${D}/usr/share/assaultcube/"
	install -Dm644 "${S}"/{CONTRIBUTING.md,GOVERNANCE.md,README.{html,md},SECURITY.md} -t "${D}/usr/share/assaultcube"

	make_desktop_entry \
				"/usr/share/assaultcube/assaultcube.sh %u" \
				AssaultCube \
				/usr/share/assaultcube/packages/misc/icon.png \
				Game \
				"Keywords=assaultcube;game;fps;\nMimeType=x-scheme-handler/assaultcube"
}

pkg_postinst() {
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
}
