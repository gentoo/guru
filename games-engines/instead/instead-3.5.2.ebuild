# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PLOCALES="cs de en es fr it nl pt ru uk"
PLOCALE_BACKUP="en"
LUA_COMPAT=( lua5-1 luajit )

inherit cmake lua-single plocale

if [[ ${PV} == *9999* ]]; then
	EGIT_REPO_URI="https://github.com/instead-hub/${PN}.git"
	inherit git-r3
else
	SRC_URI="https://github.com/instead-hub/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="INSTEAD text-based quest game engine"
HOMEPAGE="https://instead.hugeping.ru/"

LICENSE="MIT"
SLOT="0"
IUSE="doc +iconv +harfbuzz"
# gtk3 is forced since gtk2 already near its end-of-life

REQUIRED_USE="
	${LUA_REQUIRED_USE}
"

BDEPEND="
	virtual/pkgconfig
	${LUA_DEPS}
"

COMMON_DEPEND="
	${LUA_DEPS}
	media-libs/libsdl2[sound,video]
	media-libs/sdl2-image
	media-libs/sdl2-mixer
	media-libs/sdl2-ttf
	sys-libs/zlib
	x11-libs/gtk+:3
	iconv? ( >=virtual/libiconv-0-r1 )
	harfbuzz? (
		media-libs/harfbuzz
		media-libs/sdl2-ttf[harfbuzz]
	)
"

RDEPEND="${COMMON_DEPEND}"
DEPEND="${COMMON_DEPEND}"

DOCS=( AUTHORS ChangeLog README.md )

src_prepare() {
	plocale_find_changes "${S}/lang" "" ".ini"

	rm_loc() { rm "lang/$1.ini" || die; }
	plocale_for_each_disabled_locale rm_loc

	# The docs dir contains some code to build pdf out of the Markdown docs, but it requires some
	# weird util called multimarkdown, so we will just install the md's themselfs.
	if use doc; then
		EXTRA_DOCS=()
		for l in $(plocale_get_locales) ${PLOCALE_BACKUP}; do
			for d in "docs/modules-$l.md" "docs/stead3-$l.md"; do
				if [[ -f "$d" ]]; then
					EXTRA_DOCS=( "${EXTRA_DOCS[@]}" "$d" )
				fi
			done
		done

		DOCS=( "${DOCS[@]}" "${EXTRA_DOCS[@]}" )
	fi

	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DWITH_GTK2=OFF
		-DWITH_GTK3=ON
		-DWITH_LUAJIT="$(usex lua_single_target_luajit)"
		-DWITH_ICONV="$(usex iconv)"
		-DWITH_HARFBUZZ="$(usex harfbuzz)"
	)

	cmake_src_configure
}

pkg_postinst() {
	elog "The instead package contains only a game engine. The actual"
	elog "games have to be installed separately. To install a game"
	elog "download an archive and extract it to ~/.instead/games or"
	elog "to ${EPREFIX}/usr/share/instead/games."
	elog ""
	elog "A collection of various games can be found at:"
	elog "  https://instead.itch.io/"
	elog "  http://instead-games.ru/"
	elog ""
	elog "Also there are some third-party tools to manage download"
	elog "and installation of games like insteadman3:"
	elog "  https://jhekasoft.github.io/insteadman"

}
