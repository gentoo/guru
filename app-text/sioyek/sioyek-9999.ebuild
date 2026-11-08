# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit qmake-utils desktop xdg

if [[ ${PV} != 9999 ]]; then
	SRC_URI="
		https://github.com/ahrm/sioyek/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
		"
	KEYWORDS="~amd64"
else
	inherit git-r3
	EGIT_REPO_URI="https://github.com/ahrm/sioyek.git"
	EGIT_BRANCH="development"
	EGIT_SUBMODULES=()
fi

PATCHES=(
	"${FILESDIR}/unvendor.patch"
)

DESCRIPTION="Sioyek is a PDF viewer with a focus on textbooks and research papers"
HOMEPAGE="https://github.com/ahrm/sioyek"

LICENSE="GPL-3"
SLOT="0"

DEPEND="
	app-text/mupdf:=
	dev-qt/qt3d:6
	dev-qt/qtbase:6
	media-libs/harfbuzz:=
	virtual/zlib:=
"
RDEPEND="${DEPEND}"

src_compile() {
	eqmake6 pdf_viewer_build_config.pro
	emake
}

src_install() {
	dobin sioyek
	domenu resources/sioyek.desktop
	doicon resources/sioyek-icon-linux.png

	insinto /usr/share/sioyek/shaders
	doins pdf_viewer/shaders/*

	insinto /usr/share/sioyek
	doins tutorial.pdf

	insinto /etc/sioyek
	doins pdf_viewer/keys.config pdf_viewer/prefs.config

	doman resources/sioyek.1
}

pkg_postinst() {
	xdg_desktop_database_update
}
