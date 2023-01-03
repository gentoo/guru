# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs verify-sig

PARCH=openssh-9.1p1

DESCRIPTION="GTK-based passphrase dialog for use with OpenSSH"
HOMEPAGE="https://www.openssh.com/"
SRC_URI="mirror://openbsd/OpenSSH/portable/${PARCH}.tar.gz
	verify-sig? ( mirror://openbsd/OpenSSH/portable/${PARCH}.tar.gz.asc )
"
VERIFY_SIG_OPENPGP_KEY_PATH=${BROOT}/usr/share/openpgp-keys/openssh.org.asc
S="${WORKDIR}/${PARCH}"

LICENSE="BSD GPL-2"
SLOT="0"
IUSE="gtk2 +gtk3 verify-sig"
REQUIRED_USE="|| ( gtk2 gtk3 )"

RESTRICT="test"

DEPEND="
	gtk2? ( x11-libs/gtk+:2 )
	gtk3? ( x11-libs/gtk+:3 )
"
BDEPEND="
	virtual/pkgconfig
	verify-sig? ( sec-keys/openpgp-keys-openssh )
"

src_unpack() {
	default

	# We don't have signatures for HPN, X509, so we have to write this ourselves
	use verify-sig && verify-sig_verify_detached "${DISTDIR}"/${PARCH}.tar.gz{,.asc}
}

src_configure() {
	true
}

src_compile() {
	pushd contrib

	use gtk2 && emake gnome-ssh-askpass2
	use gtk3 && emake gnome-ssh-askpass3

	popd
}

src_install() {
	use gtk2 && ( dobin contrib/gnome-ssh-askpass2; \
		echo "export SSH_ASKPASS='${EPREFIX}/usr/bin/gnome-ssh-askpass2'" > "${T}/99gnome_ssh_askpass" \
		|| die "envd file creation failed" )

	use gtk3 && ( dobin contrib/gnome-ssh-askpass3; \
		echo "export SSH_ASKPASS='${EPREFIX}/usr/bin/gnome-ssh-askpass3'" > "${T}/99gnome_ssh_askpass" \
		|| die "envd file creation failed" )

	doenvd "${T}"/99gnome_ssh_askpass
}
