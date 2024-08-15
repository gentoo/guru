# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop git-r3 qmake-utils xdg

DESCRIPTION="Stremio is a modern media center for your video entertainment."
HOMEPAGE="https://github.com/Stremio/stremio-shell/ https://www.stremio.com/"
SRC_URI="https://dl.strem.io/server/v${PV}/desktop/server.js"

EGIT_REPO_URI="https://github.com/Stremio/stremio-shell.git"
EGIT_COMMIT="v${PV}"
EGIT_SUBMODULES=( '*' '-test-*' )

LICENSE="GPL-3"
SLOT="0"

RESTRICT="bindist mirror test strip"

DEPEND="
	gnome-base/librsvg
	dev-qt/qtquickcontrols
	dev-qt/qtopengl
	dev-qt/qtwebengine:5
	media-video/ffmpeg[network]
	media-video/mpv
	net-libs/nodejs[ssl]
"

src_compile() {
	eqmake5
	emake -f release.makefile
}

src_install() {
	insinto /opt/stremio
	doins build/stremio
	doins "${DISTDIR}"/server.js

	dosym -r /usr/bin/node /opt/stremio/node

	dosym -r /opt/stremio/stremio /usr/bin/${PN}
	domenu smartcode-stremio.desktop
	local x
	for x in 16 22 24 32 64 128; do
		newicon -s ${x} icons/smartcode-stremio_${x}.png smartcode-stremio.png
	done

	fperms +x /opt/stremio/stremio
}

pkg_postinst() {
	xdg_pkg_postinst
}
