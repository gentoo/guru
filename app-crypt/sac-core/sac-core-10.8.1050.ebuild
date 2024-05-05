# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Thales/Gemalto SafeNet Authentication Client for eToken 5110/5300 & IDPrime (core PKCS#11 modules)"

SRC_URI="https://nullroute.lt/tmp/2023/pkg/SAC_Linux_10.8.105_R1_GA.zip"

HOMEPAGE="https://cpl.thalesgroup.com/access-management/security-applications/authentication-client-token-management"
# see usr/share/doc copyright file
LICENSE="no-source-code EULA"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+ssl"

# binaries are already stripped
RESTRICT="strip"

inherit systemd

RDEPEND="
	dev-libs/openssl
	sys-apps/pcsc-lite
	app-crypt/ccid
	virtual/libusb:0
	ssl? ( dev-libs/libp11 )
"
DEPEND="${RDEPEND}"

S="${WORKDIR}"

src_unpack() {
	default

	cd "$S" || die

	unpack "SAC Linux ${PV} R1 GA/Installation/withoutUI/Ubuntu-2204/safenetauthenticationclient-core_${PV}_amd64.deb" || die
	unpack "./data.tar.gz" || die
}

src_install() {
	# v10.8 is 64bit only, so move to the proper libdir
	mv usr/lib usr/$(get_libdir) || die

	# libs are not marked as executable
	chmod 755 usr/$(get_libdir)/lib*.${PV} || die

	# move docs to proper location
	mkdir -p "usr/share/doc/${PF}" || die
	mv usr/share/doc/safenetauthenticationclient-core "usr/share/doc/${PF}/" || die

	# exclude already compressed file from compression
	docompress -x "/usr/share/doc/${PF}/safenetauthenticationclient-core/changelog.gz" || die

	# Create missing SONAME symlinks
	ln -s libSACLog.so.${PV} "usr/$(get_libdir)/libSACLog.so.10" || die
	ln -s libeTokenHID.so.${PV} "usr/$(get_libdir)/libeTokenHID.so.10" || die
	ln -s libIDPrimePKCS11.so.${PV} "usr/$(get_libdir)/libIDPrimePKCS11.so.10" || die
	ln -s libIDPrimeTokenEngine.so.${PV} "usr/$(get_libdir)/libIDPrimeTokenEngine.so.10" || die
	ln -s libIDClassicSISTokenEngine.so.${PV} "usr/$(get_libdir)/libIDClassicSISTokenEngine.so.10" || die
	ln -s libIDPrimeSISTokenEngine.so.${PV} "usr/$(get_libdir)/libIDPrimeSISTokenEngine.so.10" || die

	mv usr/ "${D}/" || die
	mv etc/ "${D}/" || die

	systemd_dounit "${FILESDIR}/safenetauthenticationclient.service"
}

pkg_posintst() {
	einfo "To allow pcscd access to usb devices:"
	einfo "usermod -aG usb pcscd"
}
