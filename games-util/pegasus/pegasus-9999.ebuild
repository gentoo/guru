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
>dev-qt/qtmultimedia-5.15:5[qml]
>dev-qt/qtquickcontrols2-5.15:5
>dev-qt/qtsvg-5.15:5
>dev-qt/qtsql-5.15:5[sqlite]
>dev-qt/linguist-tools-5.15:5
media-libs/libpng
media-libs/libsdl2
"

DEPEND="$RDEPEND"

src_prepare()  {
	# Patch desktop file to final path
	sed -i 's:$${INSTALL_BINDIR}:/usr/bin:g' "${S}"/src/app/platform/linux/org.pegasus_frontend.Pegasus.desktop.qmake.in
	eapply_user
}

src_configure() {
	eqmake5 USE_SDL_GAMEPAD=1 USE_SDL_POWER=1 \
		INSTALL_BINDIR="${D}/usr/bin" \
		INSTALL_DOCDIR="${D}/usr/share/doc/${PF}" \
		INSTALL_DESKTOPDIR="${D}/usr/share/applications" \
		INSTALL_ICONDIR="${D}/usr/share/icons"
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
