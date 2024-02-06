# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit qmake-utils desktop xdg

if [[ ${PV} != 9999 ]]; then
	SRC_URI="https://github.com/ahrm/sioyek/archive/refs/tags/v${PV}.tar.gz -> sioyek-2.0.0.tar.gz"
else
	inherit git-r3
	EGIT_REPO_URI="https://github.com/ahrm/sioyek.git"
fi

DESCRIPTION="Sioyek is a PDF viewer with a focus on textbooks and research papers"
HOMEPAGE="https://github.com/ahrm/sioyek"

LICENSE="GPL-3"
SLOT="0"

BDEPEND="media-libs/harfbuzz
	dev-qt/qtbase
	dev-qt/qt3d
"

src_compile() {
	#Make Mupdf specific for build
	pushd mupdf || die
	emake USE_SYSTEM_HARFBUZZ=yes
	popd || die

	eqmake5 "CONFIG+=linux_app_image" pdf_viewer_build_config.pro
	emake
}
src_install() {
	#intall bin and shaders
	insinto /opt/sioyek
	doins sioyek
	fperms +x /opt/sioyek/sioyek
	insinto /opt/sioyek/shaders
	doins pdf_viewer/shaders/*

	domenu "${FILESDIR}/sioyek.desktop"
	doicon resources/sioyek-icon-linux.png
	insinto /usr/share/sioyek && doins tutorial.pdf pdf_viewer/keys.config pdf_viewer/prefs.config
	doman resources/sioyek.1
}

pkg_postinst() {
	xdg_desktop_database_update
}
