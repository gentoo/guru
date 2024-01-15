# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PV="${PV/_p/p}"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="Portability shim for OpenBSD's rpki-client"
HOMEPAGE="https://www.rpki-client.org/"
SRC_URI="mirror://openbsd/${PN}/${PN}-${MY_PV}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="
	acct-group/_rpki-client
	acct-user/_rpki-client
"
RDEPEND="${DEPEND}"
BDEPEND="dev-build/libtool"

S="${WORKDIR}/${MY_P}"
src_configure() {
	local myeconfargs=(
		--with-rsync=rsync
		--with-base-dir="/var/cache/${PN}"
		--with-output-dir="/var/db/${PN}"
	)
	econf "${myeconfargs[@]}"
}

src_install() {
	emake DESTDIR="${D}" BINDIR="/usr/bin" MANDIR="/usr/share/man" install
	insinto /etc/rpki
	doins *.tal
	keepdir "/var/cache/rpki-client/"
	keepdir "/var/db/rpki-client/"
	fowners -R _rpki-client "/var/db/rpki-client/"
}
