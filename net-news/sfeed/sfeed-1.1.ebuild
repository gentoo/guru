# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs savedconfig

DESCRIPTION="simple RSS and Atom parser"
HOMEPAGE="https://www.codemadness.org/sfeed.html"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="git://git.codemadness.org/sfeed"
else
	SRC_URI="https://www.codemadness.org/releases/sfeed/sfeed-${PV}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="ISC"
SLOT="0"

IUSE="
	+ncurses
	+theme-mono
	theme-mono-highlight
	theme-newsboat
	theme-templeos
"
REQUIRED_USE="ncurses? ( ^^ ( theme-mono theme-mono-highlight theme-newsboat theme-templeos ) )"

DEPEND="ncurses? ( sys-libs/ncurses )"
RDEPEND="ncurses? ( !net-news/sfeed_curses ) ${DEPEND}"

src_configure() {
	# Gentoo requires -ltinfo
	sed -i \
		-e "/^#SFEED_CURSES_LDFLAGS.*-ltinfo/{s|#||g}" \
		Makefile || die "sed failed"

	if use theme-mono ; then
		SFEED_THEME="mono"
	elif use theme-mono-highlight ; then
		SFEED_THEME="mono_highlight"
	elif use theme-newsboat ; then
		SFEED_THEME="newsboat"
	elif use theme-templeos ; then
		SFEED_THEME="templeos"
	fi

	if use ncurses ; then
		SFEED_CURSES="sfeed_curses"
	else
		SFEED_CURSES=""
	fi

	restore_config themes/mono.h themes/mono_highlight.h themes/newsboat.h themes/templeos.h
}

src_compile() {
	tc-export AR CC
	emake RANLIB=$(tc-getRANLIB) \
		SFEED_CURSES="${SFEED_CURSES}" \
		SFEED_THEME="${SFEED_THEME}"
}

src_install() {
	DESTDIR="${D}" \
		emake install \
		SFEED_CURSES="${SFEED_CURSES}" \
		PREFIX="/usr" \
		MANPREFIX="/usr/share/man" \
		DOCPREFIX="/usr/share/doc/${P}"

	einstalldocs

	save_config themes/mono.h themes/mono_highlight.h themes/newsboat.h themes/templeos.h
}
