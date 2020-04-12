# Copyright 2019-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson

DESCRIPTION="Clone of the Touhou series, written in C using SDL/OpenGL/OpenAL."
HOMEPAGE="https://taisei-project.org/"
LICENSE="BSD"
SLOT="0"
SRC_URI="https://github.com/taisei-project/taisei/releases/download/v${PV}/${PN}-v${PV}.tar.xz"
KEYWORDS="~amd64"
IUSE="zip"

S="${WORKDIR}/${PN}-v${PV}"

DEPEND="
	media-libs/freetype:2
	>=media-libs/libpng-1.5
	media-libs/libsdl2
	media-libs/sdl2-mixer
	media-libs/libwebp
	sys-libs/zlib
	zip? ( dev-libs/libzip )
"

src_prepare() {
	sed -i '/strip=true/d' meson.build || die "Failed removing auto-stripping"
	sed -i "s/doc_path = join.*/doc_path = join_paths(datadir, \'doc\', \'taisei-${PV}\')/" \
		meson.build || die "Failed changing doc_path"
	default
}

src_configure() {
	local emesonargs=(
		$(meson_use zip enable_zip)
	)
	meson_src_configure
}
