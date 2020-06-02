# Copyright 2019-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	KEYWORDS=""
	EGIT_REPO_URI="https://github.com/taisei-project/taisei.git"
else
	SRC_URI="https://github.com/taisei-project/taisei/releases/download/v${PV}/${PN}-v${PV}.tar.xz"
	KEYWORDS="~amd64"
	S="${WORKDIR}/${PN}-v${PV}"
fi

DESCRIPTION="Clone of the Touhou series, written in C using SDL/OpenGL/OpenAL."
HOMEPAGE="https://taisei-project.org/"
LICENSE="MIT CC-BY-4.0 CC0-1.0 public-domain"
SLOT="0"

IUSE="doc +lto zip"

DEPEND="
	media-libs/freetype:2
	>=media-libs/libpng-1.5
	media-libs/libsdl2
	media-libs/sdl2-mixer
	media-libs/libwebp
	sys-libs/zlib
	zip? ( dev-libs/libzip )
"
BDEPEND=">=dev-util/meson-0.49
	>=dev-lang/python-3.5
	doc? ( dev-python/docutils )"

src_prepare() {
	if use doc; then
		sed -i "s/doc_path = join.*/doc_path = join_paths(datadir, \'doc\', \'${P}\')/" \
			meson.build || die "Failed changing doc_path"
	fi
	default
}

src_configure() {
	local emesonargs=(
		$(meson_use doc docs)
		$(meson_use lto b_lto)
		$(meson_use zip enable_zip)
		-Dstrip=false
	)
	meson_src_configure
}
