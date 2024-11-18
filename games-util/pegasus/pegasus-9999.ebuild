# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v3

EAPI=8

DESCRIPTION="Graphical frontend for browsing your game library"
HOMEPAGE="https://pegasus-frontend.org/"

EGIT_REPO_URI="https://github.com/mmatyas/pegasus-frontend"
EGIT_BRANCH="master"
inherit git-r3 qmake-utils xdg

LICENSE="GPL-3"
SLOT="0"

RDEPEND="
dev-qt/qtconcurrent:5
dev-qt/qtmultimedia:5[qml]
dev-qt/qtquickcontrols2:5
dev-qt/qtsvg:5
dev-qt/qtsql:5[sqlite]
media-libs/libpng
media-libs/libsdl2
"

DEPEND="$RDEPEND"

BDEPEND="dev-qt/linguist-tools:5"

src_configure() {
	eqmake5 USE_SDL_GAMEPAD=1 USE_SDL_POWER=1 \
	        INSTALL_BINDIR="${EPREFIX}/usr/bin" \
			INSTALL_DOCDIR="${EPREFIX}/usr/share/doc/${PF}" \
			INSTALL_DESKTOPDIR="${EPREFIX}/usr/share/applications" \
			INSTALL_ICONDIR="${EPREFIX}/usr/share/icons"
}

src_install() {
	emake INSTALL_ROOT="${D}" install
	dosym ../icons/64x64/apps/org.pegasus_frontend.Pegasus.png \
	/usr/share/pixmaps/org.pegasus_frontend.Pegasus.png
}
