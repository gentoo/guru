# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils desktop xdg

DESCRIPTION="GZDoom - a modder-friendly OpenGL source port based on the DOOM engine"
HOMEPAGE="https://zdoom.org"
SRC_URI="https://github.com/coelckers/${PN}/archive/g${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD BZIP2 DUMB-0.9.2 GPL-3 LGPL-3 MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="fluidsynth gtk openal openmp"

DEPEND="
	app-arch/bzip2
	dev-util/glslang
	media-libs/libsdl2[opengl]
	sys-libs/zlib
	virtual/jpeg:0
	gtk? ( x11-libs/gtk+:* )
	openal? (
		media-libs/libsndfile
		media-libs/openal
		media-sound/mpg123
	)"
RDEPEND="
	${DEPEND}
	fluidsynth? ( media-sound/fluidsynth )"

S="${WORKDIR}/${PN}-g${PV}"

src_prepare() {
	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DINSTALL_DOCS_PATH="${EPREFIX}/usr/share/doc/${P}/docs"
		-DNO_GTK="$(usex !gtk)"
		-DNO_OPENAL="$(usex !openal)"
		-DNO_OPENMP="$(usex !openmp)"
	)
	cmake-utils_src_configure
}

src_install() {
	newicon src/posix/zdoom.xpm "${PN}.xpm"
	make_desktop_entry "${PN}" "GZDoom" "${PN}" "Game;ActionGame"
	cmake-utils_src_install
}

pkg_preinst() {
	xdg_pkg_preinst
}

pkg_postinst() {
	xdg_pkg_postinst
}

pkg_postrm() {
	xdg_pkg_postrm
}
