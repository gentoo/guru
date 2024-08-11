# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop git-r3 xdg

DESCRIPTION="Stremio is a modern media center for your video entertainment."
HOMEPAGE="https://github.com/Stremio/stremio-shell https://www.stremio.com/"
SRC_URI="https://dl.strem.io/server/v${PV}/desktop/server.js"

EGIT_REPO_URI="https://github.com/Stremio/stremio-shell.git"
EGIT_COMMIT="v${PV}"
EGIT_SUBMODULES=( '*' '-test-*' )

S="${WORKDIR}"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"

RESTRICT="bindist mirror test strip"

RDEPEND="
	gnome-base/librsvg
	dev-qt/qtquickcontrols
	dev-qt/qtquickcontrols2
	dev-qt/qtopengl
	dev-qt/qtwebchannel:5
	dev-qt/qtwebengine:5
	dev-libs/wayland
	media-video/mpv
	net-libs/nodejs[ssl]
"

src_configure() {
	cd "${P}"
	qmake5
}

src_compile() {
	cd "${P}"
	emake -f release.makefile
}

src_install() {
	insinto /opt/stremio
	doins "${DISTDIR}"/server.js
	doins "${P}"/build/stremio

	dosym "/usr/bin/node" /opt/stremio/node

	dosym "/opt/stremio/stremio" /usr/bin/${PN}
	domenu "${S}"/"${P}"/smartcode-stremio.desktop
	local x
	for x in 16 22 24 32 64 128; do
		newicon -s ${x} "${S}"/"${P}"/icons/smartcode-stremio_${x}.png smartcode-stremio.png
	done

	fperms +x "/opt/stremio/stremio"

}

pkg_postinst() {
	xdg_pkg_postinst
}
