# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools fcaps systemd

MY_PN="fort"

DESCRIPTION="FORT validator is an open source RPKI validator"
HOMEPAGE="https://fortproject.net/validator?2"
SRC_URI="https://github.com/NICMx/${PN}/releases/download/${PV}/fort-${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="caps"

DEPEND="
	acct-group/fort
	acct-user/fort
	caps? ( sys-libs/libcap )
	dev-libs/jansson
	dev-libs/openssl
"
RDEPEND="
	${DEPEND}
	net-misc/rsync
"
BDEPEND="
	dev-build/automake
	dev-build/automake
"

S="${WORKDIR}/${MY_PN}-${PV}"

src_prepare() {
	default
	# Don't strip CFLAGS
	sed -i 's/fort_CFLAGS  =/fort_CFLAGS  = ${CFLAGS} /' src/Makefile.am || die
	# Don't test network
	sed -i '/http/d' test/Makefile.am || die
	# Don’t compile debug by default
	sed -i '/fort_CFLAGS/ s/ -g / /' src/Makefile.am || die
	eautoreconf
}

src_install() {
	newinitd "${FILESDIR}/${MY_PN}-1.5-initd" ${MY_PN}
	newconfd "${FILESDIR}/${MY_PN}-1.5-confd" ${MY_PN}

	emake DESTDIR="${ED}" install
	insinto /usr/share/${MY_PN}/
	insopts -m0644 -o "${MY_PN}"
	diropts -m0755 -o "${MY_PN}"
	doins -r examples/tal/

	dodoc -r examples/

	insinto /etc/fort
	newins "${FILESDIR}/fort-config.json" config.json

	systemd_dounit "${FILESDIR}/${MY_PN}-1.5.service"
}

pkg_postinst() {
	fcaps cap_net_bind_service usr/bin/fort

	einfo ""
	einfo "You have to init the TALs before the first run. To do so, run "
	einfo ""
	einfo "  su -s /bin/sh -c '${EROOT}/usr/bin/${MY_PN} --init-tals --tal /usr/share/${MY_PN}/tal/' fort"
	einfo ""
	einfo "as root."
}
