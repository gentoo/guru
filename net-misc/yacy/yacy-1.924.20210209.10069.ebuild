# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils java-pkg-2 java-ant-2 systemd versionator user

MAJOR_PV="$(get_version_component_range 1-2)"
REL_PV="$(get_version_component_range 3)"
SVN_PV="$(get_version_component_range 4)"

DESCRIPTION="YaCy - p2p based distributed web-search engine"
HOMEPAGE="http://www.yacy.net/"
SRC_URI="http://www.yacy.net/release/yacy_v${MAJOR_PV}_${REL_PV}_${SVN_PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="systemd +openrc"

DEPEND=">=virtual/jdk-1.8"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}"

EANT_BUILD_TARGET="all"
UNINSTALL_IGNORE="/usr/share/yacy/DATA"

pkg_setup() {
	enewgroup yacy
	enewuser yacy -1 -1 /var/lib/yacy yacy
}

src_install() {
	# remove win-only stuff
	find "${S}" -name "*.bat" -exec rm '{}' \; || die
	# remove init-scripts
	rm ${S}/*.sh || die
	# remove sources
	rm -r "${S}/source" || die
	rm ${S}/build.properties ${S}/build.xml

	dodoc AUTHORS NOTICE && rm AUTHORS NOTICE COPYRIGHT gpl.txt

	yacy_home="${EROOT}usr/share/${PN}"
	dodir ${yacy_home}
	cp -r ${S}/* ${D}${yacy_home} || die

	rm -r ${D}${yacy_home}/lib/*License

	dodir /var/log/yacy || die
	chown yacy:yacy "${D}/var/log/yacy" || die
	keepdir /var/log/yacy

	rmdir "$D/$yacy_home/DATA"
	dosym /var/lib/yacy /${yacy_home}/DATA

	use openrc && {
		exeinto /etc/init.d
		newexe "${FILESDIR}/yacy.rc" yacy
		insinto /etc/conf.d
		newins "${FILESDIR}/yacy.confd" yacy
	}

	use systemd && systemd_newunit "${FILESDIR}"/${PN}-ipv6.service ${PN}.service
}

pkg_postinst() {
	einfo "yacy.logging will write logfiles into /var/lib/yacy/LOG"
	einfo "To setup YaCy, open http://localhost:8090 in your browser."
}
