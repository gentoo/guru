# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop optfeature prefix qmake-utils toolchain-funcs xdg

DESCRIPTION="The Linux Crypto Undertaker"
HOMEPAGE="
	https://dyne.org/software/tomb/
	https://github.com/dyne/Tomb
"
SRC_URI="https://files.dyne.org/tomb/releases/Tomb-${PV}.tar.gz"

S="${WORKDIR}/${P^}"

# doc/literate/shocco - MIT
LICENSE="GPL-3 MIT gui? ( GPL-3+ )"
SLOT="0"
KEYWORDS="~amd64"
IUSE="gui tray"

PATCHES=(
	"${FILESDIR}/${P}-gtomb.patch"
	"${FILESDIR}/${P}-qt-tray.patch"
	"${FILESDIR}/${PN}-2.9-respect-ldflags.patch"
)

DEPEND="
	dev-libs/libgcrypt:=
	tray? (
		dev-qt/qtbase:6[gui,network,widgets]
		dev-qt/qtdeclarative:6
	)
"
RDEPEND="
	${DEPEND}
	app-crypt/gnupg
	app-crypt/pinentry
	app-shells/zsh
	sys-fs/cryptsetup
	sys-fs/e2fsprogs[tools]
	gui? ( gnome-extra/zenity )
"
BDEPEND="
	dev-python/markdown
	dev-python/pygments
	sys-devel/gettext
"

src_prepare() {
	default
	hprefixify tomb extras/gtomb
	eprefixify extras/qt-tray/main.cpp
}

src_compile() {
	export CFLAGS LDFLAGS PREFIX="${EPREFIX}/usr"
	tc-export CC

	emake all -C extras/kdf-keys
	emake all -C doc/literate
	if use tray ; then
		pushd extras/qt-tray > /dev/null || die
		eqmake6
		emake all
		popd > /dev/null || die
	fi
}

src_test() {
	# test require sudo, can't be done non interactively
	# emake TEST_OPTS="--verbose --immediate --root="${T}"/tomb/sharness" test
	emake test -C extras/kdf-keys
}

src_install() {
	local -x DESTDIR="${D}"

	default
	emake install -C extras/translations
	emake install -C extras/kdf-keys
	if use gui ; then
		pushd extras/gtomb > /dev/null || die
		dobin gtomb
		newdoc README.md README-gtomb
		popd > /dev/null || die
	fi
	if use tray ; then
		pushd extras/qt-tray > /dev/null || die
		dobin tomb-qt-tray
		doicon pixmaps/tomb_icon.png
		insinto /usr/share/locale/it_IT/LC_MESSAGES
		doins i18n/tomb-qt-tray_it.qm
		popd > /dev/null || die
	fi

	pushd extras/gtk-tray > /dev/null  || die
	doicon monmort.xpm
	newicon --context mimetypes --size 32 monmort.xpm monmort
	newicon --size 32 monmort.xpm dyne-monmort
	popd > /dev/null || die

	pushd extras/desktop > /dev/null || die
	insinto /usr/share/mime/packages
	doins dyne-tomb.xml
	domenu tomb.desktop
	insinto /usr/share/mime-info
	doins tomb.mime
	doins tomb.keys
	insinto /usr/share/application-registry
	doins tomb.applications
	popd > /dev/null || die

	local DOCS=(
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
	einstalldocs
	cd doc/literate || die
	docinto html
	dodoc -r *.html *.css public
}

pkg_postinst() {
	xdg_pkg_postinst
	optfeature "Argon2 KDF" app-crypt/argon2
	optfeature "ACL" sys-apps/acl
	optfeature "privilege escalation to superuser" app-admin/doas app-admin/sudo sys-auth/polkit
	optfeature "fancy dd output" sys-apps/dcfldd
	optfeature "tomb index/search file contents" app-misc/recoll
	optfeature "tomb index/search file names" sys-apps/mlocate sys-apps/plocate
	optfeature "tomb engrave" "media-gfx/qrencode[png]"
	optfeature "tomb slam" sys-process/lsof
}
