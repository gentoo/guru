# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

MYP="${P^}"

inherit desktop qmake-utils toolchain-funcs xdg

DESCRIPTION="Tomb :: File Encryption on GNU/Linux"
HOMEPAGE="
	https://www.dyne.org/software/tomb
	https://github.com/dyne/Tomb
"
SRC_URI="https://files.dyne.org/tomb/releases/Tomb-${PV}.tar.gz"
S="${WORKDIR}/${MYP}"
LICENSE="
	GPL-3
	gui? ( GPL-3+ )
"
SLOT="0"
KEYWORDS="~amd64"
IUSE="gui test tray"

#test require sudo, can't be done non interactively
RESTRICT="test"
PATCHES=(
	"${FILESDIR}/${P}-gtomb.patch"
	"${FILESDIR}/${P}-respect-ldflags.patch"
)
DOCS=(
	AUTHORS.txt
	ChangeLog.txt
	KNOWN_BUGS.txt
	README.txt
	doc/bertini_thesis.pdf
	doc/HACKING.txt
	doc/KEY_SPECIFICATIONS.txt
	doc/LinuxHDEncSettings.txt
	doc/Luks_on_disk_format.pdf
	doc/New_methods_in_HD_encryption.pdf
	doc/TKS1-draft.pdf
	doc/tomb_manpage.pdf
)

CDEPEND="
	dev-libs/libgcrypt
	tray? (
		dev-qt/qtcore:5
		dev-qt/qtgui:5
		dev-qt/qtwidgets:5
	)
"
RDEPEND="
	${CDEPEND}
	app-admin/sudo
	app-crypt/gnupg
	app-crypt/pinentry
	app-shells/zsh
	sys-fs/cryptsetup
	gui? ( gnome-extra/zenity )
"
DEPEND="${CDEPEND}"
BDEPEND="
	dev-python/markdown
	dev-python/pygments
	sys-devel/gettext
"

src_compile() {
	export CC=$(tc-getCC)
	export PREFIX="${EPREFIX}/usr"
	emake

	pushd extras/kdf-keys || die
	emake all
	popd || die

	if use tray ; then
		pushd extras/qt-tray || die
		eqmake5
		emake all
		popd || die
	fi

	#translations
	pushd extras/translations || die
	emake all
	popd || die

	#documentation
	cd doc/literate || die
	emake
}

src_install() {
	default

	#translations
	export PREFIX="${ED}/usr"
	pushd extras/translations || die
	emake install
	popd || die

	#zenity gui
	if use gui ; then
		pushd extras/gtomb || die
		dobin gtomb
		newdoc README.md README-gtomb
		popd || die
	fi

	#qt tray
	if use tray ; then
		pushd extras/qt-tray || die
		dobin tomb-qt-tray
		doicon pixmaps/tomb_icon.png
		insinto /usr/share
		doins -r i18n
		popd || die
	fi

	#kdf programs
	pushd extras/kdf-keys || die
	emake install
	popd || die

	#is there an eclass for this?
	#pixmap
	pushd extras/gtk-tray
	doicon monmort.xpm
	newicon --context mimetypes --size 32 monmort.xpm monmort
	newicon --size 32 monmort.xpm dyne-monmort
	popd
	pushd extras/desktop
	#copied from install.zsh
	#mime types
	insinto /usr/share/mime/packages
	doins dyne-tomb.xml
	#desktop
	domenu tomb.desktop
	#menu
	insinto /etc/menu
	doins tomb
	#mime info
	insinto /usr/share/mime-info
	doins tomb.mime
	doins tomb.keys
	insinto /usr/lib/mime/packages
	newins tomb.mimepkg tomb
	#application entry
	insinto /usr/share/application-registry
	doins tomb.applications
	popd

	#documentation
	einstalldocs
	cd doc/literate || die
	insinto "/usr/share/doc/${PF}/html"
	doins -r *.html *.css public
}

src_test() {
	emake test

	pushd extras/kdf-keys || die
	emake test
}
