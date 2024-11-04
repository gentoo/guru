# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit java-pkg-2 systemd

MAJOR_PV="$(ver_cut 1-2)"
REL_PV="$(ver_cut 3)"
COMMIT="59c0cb0f3"

DESCRIPTION="YaCy - p2p based distributed web-search engine"
HOMEPAGE="https://www.yacy.net/"
SRC_URI="https://download.yacy.net/yacy_v${MAJOR_PV}_${REL_PV}_${COMMIT}.tar.gz"

S="${WORKDIR}/${PN}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="
	>=virtual/jdk-1.8
	acct-group/yacy
	acct-user/yacy
"
RDEPEND="${DEPEND}"

EANT_BUILD_TARGET="all"
UNINSTALL_IGNORE="/usr/share/yacy/DATA"

src_install() {
	# remove win-only stuff
	find "${S}" -name "*.bat" -exec rm '{}' \; || die
	# remove init-scripts
	rm "${S}"/*.sh || die
	# remove sources
	rm -r "${S}/source" || die
	rm "${S}/build.properties" "${S}/build.xml" || die

	dodoc AUTHORS NOTICE && rm AUTHORS NOTICE COPYRIGHT gpl.txt

	yacy_home="${EROOT}/usr/share/${PN}"
	dodir ${yacy_home}
	cp -r "${S}"/* "${D}${yacy_home}" || die

	rm -r "${D}${yacy_home}"/lib/*License

	dodir /var/log/yacy || die
	chown yacy:yacy "${D}/var/log/yacy" || die
	keepdir /var/log/yacy

	dosym /var/lib/yacy /${yacy_home}/DATA

	exeinto /etc/init.d
	newexe "${FILESDIR}/yacy.rc" yacy
	doconfd "${FILESDIR}/yacy.confd"

	systemd_newunit "${FILESDIR}"/${PN}-ipv6.service ${PN}.service
}

pkg_postinst() {
	einfo "yacy.logging will write logfiles into /var/lib/yacy/LOG"
	einfo "To setup YaCy, open http://localhost:8090 in your browser."
}
