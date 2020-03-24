# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools git-r3 systemd

DESCRIPTION="OpenBGPD is a free implementation of BGPv4"
HOMEPAGE="http://www.openbgpd.org/index.html"
EGIT_REPO_URI="https://github.com/openbgpd-portable/openbgpd-portable.git"

LICENSE="ISC"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=""
RDEPEND="
	${DEPEND}
	!!net-misc/quagga
	acct-group/_bgpd
	acct-user/_bgpd
"
BDEPEND="
	dev-util/byacc
	sys-devel/autoconf
	sys-devel/automake
	sys-devel/libtool
"

src_unpack() {
	git-r3_src_unpack

	cd "${WORKDIR}"

	EGIT_REPO_URI="https://github.com/openbgpd-portable/openbgpd-openbsd.git"
	EGIT_BRANCH=$(cat "${S}"/OPENBSD_BRANCH)
	EGIT_CHECKOUT_DIR="${S}/openbsd"
	git-r3_fetch
	git-r3_checkout
}

src_prepare() {
	eapply -p0 "${FILESDIR}/${P}-update.patch"
	eapply -p0 "${FILESDIR}/${P}-config.c.patch"
	default
	./autogen.sh
	eautoreconf
}

src_configure() {
	export YACC=byacc
	default
}

src_install() {
	default

	newinitd "${FILESDIR}/${PN}-init.d" bgpd
	newconfd "${FILESDIR}/${PN}-conf.d" bgpd
	systemd_newunit "${FILESDIR}/${PN}.service" bgpd.service
}

pkg_postinst() {
	ewarn ""
	ewarn "OpenBGPD portable (not running on OpenBSD) can’t export its RIB to"
	ewarn "the FIB. It’s only suitable for route-reflectors or route-servers."
	ewarn ""
}
