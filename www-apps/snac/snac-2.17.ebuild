# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit systemd toolchain-funcs

MY_PN="snac2"
DESCRIPTION="A simple, minimalistic ActivityPub instance"
HOMEPAGE="https://codeberg.org/grunfink/snac2"
SRC_URI="https://codeberg.org/grunfink/${MY_PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_PN}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-libs/openssl:=
	net-misc/curl
"
RDEPEND="${DEPEND}
	acct-user/snac
"

DOCS=( {README,RELEASE_NOTES,TODO}.md )

src_configure() {
	tc-export CC
}

src_compile() {
	emake CFLAGS="${CFLAGS}"
}

src_install() {
	mkdir -p "${ED}"/usr/bin
	emake PREFIX="${ED}/usr" PREFIX_MAN="${ED}/usr/share/man" install
	einstalldocs

	doinitd "${FILESDIR}"/snac
	systemd_dounit "${FILESDIR}"/snac.service

	diropts --owner snac --group snac
	keepdir /var/lib/snac
}

pkg_postinst() {
	if [[ -z ${REPLACING_VERSIONS} ]]; then
		einfo "To finish the installation, please run:"
		einfo " # rc-service snac init"
	fi
}
