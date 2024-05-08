# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit systemd unpacker

DESCRIPTION="Thales/Gemalto SafeNet Authentication Client"
HOMEPAGE="https://cpl.thalesgroup.com/access-management/security-applications/authentication-client-token-management"
SRC_URI="https://nullroute.lt/tmp/2023/pkg/SAC_Linux_10.8.105_R1_GA.zip"

S="${WORKDIR}"

LICENSE="sac-core-10.8.1050-terms LGPL-2.1 ZLIB"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+ssl"

# binaries are already stripped
RESTRICT="bindist mirror strip"

RDEPEND="
	dev-libs/openssl
	sys-apps/pcsc-lite
	app-crypt/ccid
	virtual/libusb:0
	ssl? ( dev-libs/libp11 )
"
DEPEND="${RDEPEND}"
BDEPEND="app-arch/unzip"

QA_FLAGS_IGNORED="
	usr/bin/SACSrv
	usr/lib64/.*
"
QA_PREBUILT="${QA_FLAGS_IGNORED}"

src_unpack() {
	default
	unpacker "SAC Linux ${PV} R1 GA/Installation/withoutUI/Ubuntu-2204/safenetauthenticationclient-core_${PV}_amd64.deb"
}

src_install() {
	dobin usr/bin/SACSrv

	find usr/lib -maxdepth 1 -name "*.so*" -exec dolib.so {} + || die
	dodir /usr/$(get_libdir)/pkcs11
	insinto /usr/$(get_libdir)
	doins -r usr/lib/pkcs11

	# Create missing SONAME symlinks
	for libname in eTokenHID ID{{Prime,Classic}SISTokenEngine,Prime{PKCS11,TokenEngine}} SACLog
	do
		dosym -r /usr/$(get_libdir)/lib${libname}.so.{${PV},10}
	done

	# compress documentation with $PORTAGE_COMPRESS
	gunzip usr/share/doc/safenetauthenticationclient-core/changelog.gz || die
	dodoc usr/share/doc/safenetauthenticationclient-core/changelog

	insinto /etc
	doins -r etc/*

	systemd_dounit "${FILESDIR}/safenetauthenticationclient.service"
}

pkg_posintst() {
	einfo "To allow pcscd access to usb devices:"
	einfo "usermod -aG usb pcscd"
}
