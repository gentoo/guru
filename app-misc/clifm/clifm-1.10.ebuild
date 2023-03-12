# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="The command line file manager"
HOMEPAGE="https://github.com/leo-arch/clifm"

inherit optfeature xdg

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
IUSE=""

PATCHES=(
	"${FILESDIR}/${P}-gentoo-skip-manpage-compression.patch"
)

DEPEND="
	sys-libs/libcap
	sys-libs/readline:=
	sys-apps/acl
	sys-apps/file
"
RDEPEND="${DEPEND}"
BDEPEND=""

src_compile() {
	# makefile defaults to /usr/local
	emake PREFIX="/usr"
}

src_install() {
	# makefile defaults to /usr/local, and manpages to /usr/man
	emake DESTDIR="${D}" PREFIX="/usr" MANDIR="/usr/share/man" install
	einstalldocs
}

pkg_postinst() {
	optfeature_header "Install additional optional functionality:"
	optfeature "fzf tab completion and more" app-shells/fzf
	optfeature "mounting/unmounting support" sys-fs/udisks sys-apps/udevil
	optfeature_header "Install optional archiving support (if you didn't use -D_NO_ARCHIVING):"
	optfeature "zstd operations" app-arch/zstd
	optfeature "archive extraction/unpacking" app-arch/atool
	optfeature "mounting archives" sys-fs/archivemount
	optfeature "extracting .iso files" app-arch/p7zip
	optfeature "creating .iso files" app-cdr/cdrtools
	xdg_pkg_postinst
}
