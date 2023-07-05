# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 qmake-utils desktop
EGIT_REPO_URI="https://github.com/ahrm/sioyek.git"
DESCRIPTION="Sioyek is a PDF viewer with a focus on textbooks and research papers"
HOMEPAGE="https://github.com/ahrm/sioyek"

LICENSE="GPL-3"
SLOT="0"

BDEPEND="media-libs/harfbuzz
    dev-qt/qtbase
    dev-qt/qt3d"

KEYWORDS="~amd64~x86"

src_prepare() {
    #Make Mupdf specific for build
    pushd mupdf || die
    emake USE_SYSTEM_HARFBUZZ=yes
    popd || die

    eapply_user
    eqmake5 "CONFIG+=linux_app_image" pdf_viewer_build_config.pro
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