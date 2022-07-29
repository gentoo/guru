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
	SRC_URI="mirror://sourceforge/${PN}/v${PV}.tar.gz -> ${P}.tar.gz"
	# also on github but seems like a worse alternative?
	# SRC_URI="https://github.com/leo-arch/clifm/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE="+archives +bleach emoji-icons +highlight icons-in-terminal +lira
		nerdfonts +suggestions +tags +trash"

DEPEND="
	sys-libs/libcap
	sys-libs/readline
	sys-apps/acl
	sys-apps/file
"
RDEPEND="${DEPEND}"
BDEPEND=""

src_compile() {
	use archives || append-cflags "-D_NO_ARCHIVING"
	use bleach || append-cflags "-D_NO_BLEACH"

	# emoji-icons > nerdfonts > icons-in-terminal
	if ! use emoji-icons; then # support for emoji-icons is default
		if use nerdfonts; then
			append-cflags "-D_NERD"
		elif use icons-in-terminal; then
			append-cflags "-D_ICONS_IN_TERMINAL"
		else
			append-cflags "-D_NO_ICONS"
		fi
	fi

	use highlight || append-cflags "-D_NO_HIGHLIGHT"
	use lira || append-cflags "-D_NO_LIRA"
	use suggestions || append-cflags "-D_NO_SUGGESTIONS"
	use tags || append-cflags "-D_NO_TAGS"
	use trash || append-cflags "-D_NO_TRASH"
	# there is no reason to use -D_NO_MAGIC since we already depend on sys-apps/file

	# basically free faster qsort implementation
	append-cflags "-D_TOURBIN_QSORT"

	# makefile defaults to /usr/local
	emake PREFIX="/usr" || die "make failed"
}

src_install() {
	docompress -x /usr/share/man # makefile compresses man page
	# makefile defaults to /usr/local, and manpages to /usr/man
	emake DESTDIR="${D}" PREFIX="/usr" MANDIR="/usr/share/man" install || die "install failed"
	einstalldocs
}

pkg_postinst() {
	optfeature_header "Install additional optional functionality:"
	optfeature "fzf tab completion and more" app-shells/fzf
	optfeature "mounting/unmounting support" sys-fs/udisks sys-apps/udevil
	optfeature_header "Install optional archiving support:"
	optfeature "zstd operations" app-arch/zstd
	optfeature "archive extraction/unpacking" app-arch/atool
	optfeature "mounting archives" sys-fs/archivemount
	optfeature "extracting .iso files" app-arch/p7zip
	optfeature "creating .iso files" app-cdr/cdrtools
	if use emoji-icons; then
		use nerdfonts && ewarn "Warning: Use flag 'nerdfonts' overridden by 'emoji-icons'"
		use icons-in-terminal && ewarn "Warning: Use flag 'icons-in-terminal' overridden by 'emoji-icons'"
	elif use nerdfonts; then
		use icons-in-terminal && ewarn "Warning: Use flag 'icons-in-terminal' overridden by 'nerdfonts'"
	fi
}
