# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic

MY_PV="$(ver_cut 1)_$(ver_cut 2)"

DESCRIPTION="CLI for the KDE Wallet"
HOMEPAGE="http://www.mirbsd.org/kwalletcli.htm"
SRC_URI="https://github.com/MirBSD/kwalletcli/archive/refs/tags/kwalletcli-$MY_PV.tar.gz"
S="${WORKDIR}/${PN}-${PN}-${MY_PV}"

LICENSE="MirOS"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	kde-frameworks/kcoreaddons:5
	kde-frameworks/ki18n:5
	kde-frameworks/kwallet:5
"

PDEPEND="
	app-shells/mksh
"

PATCHES=( "${FILESDIR}/pinentry-qt-interaction-${PV}.patch" )

src_compile() {
	append-flags "-fPIC"
	append-ldflags "-fPIC"
	emake KDE_VER=5
}

src_install() {
	mkdir -p "${ED}/usr/bin" || die
	mkdir -p "${ED}/usr/share/man/man1" || die
	emake DESTDIR="${ED}" INSTALL_STRIP= install
	einstalldocs
}

pkg_postinst() {
	elog "To use pinentry-kwallet with GnuPG, add/change the line:"
	elog "   pinentry-program /usr/bin/pinentry-kwallet"
	elog "to ~/.gnupg/gpg-agent.conf"
	elog "then restart your gnupg-agent with"
	elog "   gpg-connect-agent reloadagent /bye"
}
