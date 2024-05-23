# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="The command line file manager"
HOMEPAGE="https://github.com/leo-arch/clifm"

inherit flag-o-matic optfeature xdg

if [[ ${PV} == "9999" ]]; then
	EGIT_REPO_URI="https://github.com/leo-arch/clifm.git"
	inherit git-r3
else
	SRC_URI="https://github.com/leo-arch/clifm/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	# also on sourceforge but the unpacked name is irregular
	# SRC_URI="https://downloads.sourceforge.net/${PN}/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE="archive +bleach emoji fzf +highlight icons +lira +magic nerdfonts nls
		posix +profiles qsort +suggestions +tags +trash"

PATCHES=(
	"${FILESDIR}/${P}-gentoo-skip-manpage-compression.patch"
)

LIB="
	sys-libs/libcap
	sys-libs/readline:=
	sys-apps/acl
	magic? ( sys-apps/file )
"

DEPEND="
	${LIB}
	nls? ( sys-devel/gettext )
"
RDEPEND="
	${LIB}
	archive? (
		app-arch/atool
		sys-fs/archivemount
	)
	fzf? ( app-shells/fzf )
	nls? ( virtual/libintl )
"

src_compile() {
	# emoji > nerdfonts > icons
	if ! use emoji; then # support for emoji-icons is default
		if use nerdfonts; then
			append-cflags "-D_NERD"
		elif use icons; then
			append-cflags "-D_ICONS_IN_TERMINAL"
		else
			append-cflags "-D_NO_ICONS"
		fi
	fi

	use posix && append-cflags "-D_BE_POSIX"
	use archive || append-cflags "-D_NO_ARCHIVING"
	use bleach || append-cflags "-D_NO_BLEACH"
	use nls || append-cflags "-D_NO_GETTEXT"
	use fzf || append-cflags "-D_NO_FZF"
	use highlight || append-cflags "-D_NO_HIGHLIGHT"
	use lira || append-cflags "-D_NO_LIRA"
	use magic || append-cflags "-D_NO_MAGIC"
	use suggestions || append-cflags "-D_NO_SUGGESTIONS"
	use tags || append-cflags "-D_NO_TAGS"
	use profiles || append-cflags "-D_NO_PROFILES"
	use trash || append-cflags "-D_NO_TRASH"
	use qsort && append-cflags "-D_TOURBIN_QSORT"

	# makefile defaults to /usr/local
	emake PREFIX="/usr"
}

src_install() {
	# makefile defaults to /usr/local, and manpages to /usr/man
	emake DESTDIR="${D}" PREFIX="/usr" MANDIR="/usr/share/man" install
	einstalldocs
}

pkg_postinst() {
	xdg_pkg_postinst
	if use emoji; then
		use nerdfonts && ewarn "Warning: Use flag 'nerdfonts' overridden by 'emoji'"
		use icons && ewarn "Warning: Use flag 'icons' overridden by 'emoji'"
	elif use nerdfonts; then
		use icons && ewarn "Warning: Use flag 'icons' overridden by 'nerdfonts'"
	fi
	optfeature_header "Install additional optional functionality:"
	optfeature "mounting/unmounting support" sys-apps/udevil sys-fs/udisks
	if use archive; then
		optfeature_header "Install additional archive support:"
		optfeature "zstd support" app-arch/zstd
		optfeature "extracting .iso files" app-arch/p7zip
		optfeature "creating .iso files" app-cdr/cdrtools
	fi
}
