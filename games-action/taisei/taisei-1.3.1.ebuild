# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	KEYWORDS=""
	EGIT_REPO_URI="https://github.com/taisei-project/taisei.git"
else
	SRC_URI="https://github.com/taisei-project/${PN}/releases/download/v${PV}/${PN}-v${PV}.tar.xz"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}/${PN}-v${PV}"
fi

inherit meson

DESCRIPTION="A free and open-source Touhou Project clone and fangame"
HOMEPAGE="https://taisei-project.org/"

LICENSE="MIT CC-BY-4.0 CC0-1.0 public-domain"
SLOT="0"
IUSE="doc +lto"

RDEPEND="
	>=media-libs/libsdl2-2.0.6
	>=media-libs/sdl2-mixer-2.0.4
	media-libs/freetype:2
	>=media-libs/libpng-1.5
	>=media-libs/libwebp-0.5
	>=dev-libs/libzip-1.2
	media-libs/opusfile
	dev-libs/openssl
	media-libs/shaderc
	dev-util/spirv-tools"
DEPEND="${RDEPEND}"
BDEPEND=">=dev-util/meson-0.49
	>=dev-lang/python-3.5
	doc? ( dev-python/docutils )"

src_prepare() {
	if use doc; then
		# Fixup install path for documentation.
		sed -i "s/doc_path = join_paths(datadir, 'doc', 'taisei')/doc_path = join_paths(datadir, 'doc', '"${P}"')/" meson.build || die
	fi
	default
}

src_configure() {
	local emesonargs=(
		$(meson_use doc docs)
		$(meson_use lto b_lto)
		# Stips binary by default otherwise.
		-Dstrip=false
	)
	meson_src_configure
}
