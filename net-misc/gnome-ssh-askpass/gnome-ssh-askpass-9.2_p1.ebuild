# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs verify-sig

MY_P="openssh-${PV/_p/p}"
DESCRIPTION="GTK-based passphrase dialog for use with OpenSSH"
HOMEPAGE="https://www.openssh.com/"
SRC_URI="mirror://openbsd/OpenSSH/portable/${MY_P}.tar.gz
	verify-sig? ( mirror://openbsd/OpenSSH/portable/${MY_P}.tar.gz.asc )
"
S="${WORKDIR}/${MY_P}/contrib"

LICENSE="BSD GPL-2"
SLOT="0"
RESTRICT="test"

RDEPEND="
	dev-libs/glib:2
	x11-libs/gtk+:3
"
DEPEND="${RDEPEND}"
BDEPEND="
	virtual/pkgconfig
	verify-sig? ( sec-keys/openpgp-keys-openssh )
"

VERIFY_SIG_OPENPGP_KEY_PATH="/usr/share/openpgp-keys/openssh.org.asc"

src_unpack() {
	default

	# We don't have signatures for HPN, X509, so we have to write this ourselves
	use verify-sig && \
		verify-sig_verify_detached "${DISTDIR}"/${MY_P}.tar.gz{,.asc}
}

src_configure() {
	tc-export CC
}

src_compile() {
	emake gnome-ssh-askpass3
}

src_install() {
	dobin gnome-ssh-askpass3;

	newenvd - 99gnome_ssh_askpass <<-EOF
		export SSH_ASKPASS='${EPREFIX}/usr/bin/gnome-ssh-askpass3'
	EOF
}
