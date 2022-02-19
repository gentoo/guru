# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs savedconfig

DESCRIPTION="simple RSS and Atom parser"
HOMEPAGE="https://www.codemadness.org/sfeed.html"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="git://git.codemadness.org/sfeed"
else
	SRC_URI="https://www.codemadness.org/releases/${PN}/${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="ISC"
SLOT="0"

THEMES=( mono{,-highlight} newsboat templeos )
IUSE="+ncurses +$(printf "theme-%s " ${THEMES[@]})"
REQUIRED_USE="ncurses? ( ^^ ( $(printf "theme-%s " ${THEMES[@]}) ) )"

DEPEND="ncurses? ( sys-libs/ncurses )"
RDEPEND="${DEPEND}
	ncurses? ( !net-news/sfeed_curses )
"
BDEPEND="virtual/pkgconfig"

src_configure() {
	for name in "${THEMES[@]}"; do
		if use theme-${name}; then
			SFEED_THEME="${name//-/_}"
		fi
	done

	use ncurses && SFEED_CURSES="sfeed_curses"

	restore_config $(printf "themes/%s.h " ${THEMES[@]//-/_})
}

src_compile() {
	tc-export AR CC
	emake RANLIB=$(tc-getRANLIB) \
		SFEED_CURSES="${SFEED_CURSES}" \
		SFEED_THEME="${SFEED_THEME}" \
		SFEED_CURSES_LDFLAGS="${LDFLAGS} $(pkg-config --libs ncurses)"
}

src_install() {
	DESTDIR="${D}" \
		emake install \
		SFEED_CURSES="${SFEED_CURSES}" \
		PREFIX="${EPREFIX}/usr" \
		MANPREFIX="${EPREFIX}/usr/share/man" \
		DOCPREFIX="${EPREFIX}/usr/share/doc/${PF}"

	einstalldocs

	save_config $(printf "themes/%s.h " ${THEMES[@]//-/_})
}
