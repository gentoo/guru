# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools git-r3 systemd

MY_PV="master"
MY_PN="openbgpd-portable"
MY_P="${MY_PN}-${MY_PV}"

DESCRIPTION="OpenBGPD is a free implementation of BGPv4"
HOMEPAGE="http://www.openbgpd.org/index.html"
SRC_URI="https://github.com/${MY_PN}/${MY_PN}/archive/master.zip -> ${MY_P}.zip"

EGIT_REPO_URI="https://github.com/openbgpd-portable/openbgpd-openbsd.git"
EGIT3_STORE_DIR="${S}/git"
EGIT_CHECKOUT_DIR="${S}/openbsd"

LICENSE="ISC"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=""
RDEPEND="
	${DEPEND}
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
	unpack ${A}
	mv "${WORKDIR}/${MY_P}" "${S}"

	EGIT_BRANCH=$(cat "${S}"/OPENBSD_BRANCH)
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
