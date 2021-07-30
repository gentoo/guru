# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit savedconfig toolchain-funcs

DESCRIPTION="A curses UI front-end for sfeed"
HOMEPAGE="https://codemadness.org/sfeed_ui.html"

SRC_URI="https://codemadness.org/releases/sfeed_curses/sfeed_curses-${PV}.tar.gz"

KEYWORDS="~amd64"
LICENSE="ISC"
SLOT="0"

IUSE="
	+theme-mono
	theme-mono_highlight
	theme-newsboat
	theme-templeos
"
REQUIRED_USE="^^ ( theme-mono theme-mono_highlight theme-newsboat theme-templeos )"

DEPEND="sys-libs/ncurses"
RDEPEND="${DEPEND}"

src_configure() {
	# Gentoo requires -ltinfo
	sed -i \
		-e "/^#SFEED_LDFLAGS.*-ltinfo/{s|#||g}" \
		Makefile || die "sed failed"

	if use theme-mono ; then
		SFEED_THEME="mono"
	elif use theme-mono_highlight ; then
		SFEED_THEME="mono_highlight"
	elif use theme-newsboat ; then
		SFEED_THEME="newsboat"
	elif use theme-templeos ; then
		SFEED_THEME="templeos"
	fi

	restore_config themes/mono.h themes/mono_highlight.h themes/newsboat.h themes/templeos.h
}

src_compile() {
	emake CC=$(tc-getCC) SFEED_THEME=${SFEED_THEME}
}

src_install() {
	emake \
		DESTDIR="${D}" \
		PREFIX="/usr" \
		MANPREFIX="/usr/share/man" \
		DOCPREFIX="/usr/share/doc/${PF}" \
		install

	save_config themes/mono.h themes/mono_highlight.h themes/newsboat.h themes/templeos.h
}
