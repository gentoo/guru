# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop xdg-utils flag-o-matic

DESCRIPTION="Free multiplayer FPS based on the Cube engine"
HOMEPAGE="https://assault.cubers.net/"
SRC_URI="https://github.com/assaultcube/AC/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/AC-${PV}"

LICENSE="ZLIB assaultcube"
SLOT="0"
KEYWORDS="~amd64"
IUSE="debug"

RDEPEND="
	sys-libs/zlib
	media-libs/libsdl2[opengl]
	media-libs/sdl2-image[jpeg,png]
	x11-libs/libX11
	media-libs/libglvnd[X]
	media-libs/libogg
	media-libs/libvorbis
	media-libs/openal
"
DEPEND="${RDEPEND}"
PATCHES=(
	"${FILESDIR}/${PN}-1.3.0.2-respect-ldflags.patch"
	# a script which checks for required libs and certain parts of the game
	"${FILESDIR}/${PN}-1.3.0.2-fix-checkinstall.patch"
	# bug #921915
	"${FILESDIR}/${PN}-1.3.0.2-unset-variables.patch"
	"${FILESDIR}/0001-Fix-unnecessary-rebuild-on-make-install.patch"
	"${FILESDIR}/0002-Don-t-configure-libenet-in-Makefile.patch"
)
RESTRICT="mirror"

src_prepare() {
	default
	sed -i 's|//#define PRODUCTION|#define PRODUCTION|' source/src/cube.h || die
}

src_configure() {
	filter-lto
	cd source/enet && ./configure \
		--enable-shared=no \
		--enable-static=yes
}

src_compile() {
	if use debug; then
		local -x DEBUGBUILD=1
	fi
	emake -C source/enet
	emake -C source/src
}

src_install() {
	emake -C source/src install

	install -dm755 "${ED}/usr/share/assaultcube" || die
	install -Dm755 "${S}"/{assaultcube.sh,check_install.sh,server.sh,server_wizard.sh} \
			-t "${ED}/usr/share/assaultcube" || die
	install -Dm755 "${S}"/bin_unix/native_{client,server} -t "${ED}/usr/share/assaultcube/bin_unix" || die
	cp -r {bot,config,demos,docs,mods,packages} "${ED}/usr/share/assaultcube/" || die

	dodoc CONTRIBUTING.md GOVERNANCE.md README.{html,md} SECURITY.md

	make_desktop_entry \
				"${EPREFIX}/usr/share/assaultcube/assaultcube.sh %u" \
				AssaultCube \
				/usr/share/assaultcube/packages/misc/icon.png \
				Game \
				"Keywords=assaultcube;game;fps;\nMimeType=x-scheme-handler/assaultcube"

	dosym -r "${EPREFIX}/usr/share/assaultcube/assaultcube.sh" "${EPREFIX}/usr/bin/assaultcube"
}

pkg_postinst() {
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
}
