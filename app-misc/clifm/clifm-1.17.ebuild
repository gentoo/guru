# Copyright 2022 Gentoo Authors
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
	# SRC_URI="mirror://sourceforge/${PN}/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE="arc4random archive +bleach emoji fzf +highlight icons +inotify +lira +magic
		+media nerdfonts nls posix +profiles qsort +suggestions +tags +trash xdu"

PATCHES=(
	"${FILESDIR}/${PN}-1.12-gentoo-skip-manpage-compression.patch"
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
	media? (
		|| (
			sys-apps/udevil
			sys-fs/udisks
		)
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
		# else
			# the following line is desired but would cause a compile error
			# append-cflags "-D_NO_ICONS"
		fi
	fi

	use posix && append-cflags "-DPOSIX_STRICT"
	use archive || append-cflags "-D_NO_ARCHIVING"
	use arc4random || append-cflags "-D_NO_ARC4RANDOM"
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
	use inotify || append-cflags "-DUSE_GENERIC_FS_MONITOR"
	use media || append-cflags "-DNO_MEDIA_FUNC"
	use xdu && append-cflags "-DUSE_XDU"

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
	use inotify && use posix && ewarn "Warning: Use flag 'inotify' overriden by 'posix'"
	use arc4random && use posix && ewarn "Warning: Use flag 'arc4random' overriden by 'posix'"
	if use archive; then
		optfeature_header "Install additional archive support:"
		optfeature "zstd support" app-arch/zstd
		optfeature "extracting .iso files" app-arch/p7zip
		optfeature "creating .iso files" app-cdr/cdrtools
	fi
}
