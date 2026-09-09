# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="DN42 root certificates"
HOMEPAGE="https://dn42.eu/services/ca/Certificate-Authority"

S="${WORKDIR}"

LICENSE="CC0-1.0"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64"
BDEPEND="dev-libs/openssl"
RDEPEND=">=app-misc/ca-certificates-20260601.3.112.5"

src_unpack() {
	cp "${FILESDIR}/dn42-ca-${PV}.crt" "${WORKDIR}/" || die
}

src_prepare() {
	default

	if ! openssl x509 -in "dn42-ca-${PV}.crt" -noout -text \
		| grep -A1 'Permitted:' | grep -q 'DNS:\.dn42' ; then
		die "Certificate is missing the expected DNS:.dn42 name constraint; refusing to install it."
	fi
}

src_install() {
	insinto /usr/share/ca-certificates/dn42
	newins "dn42-ca-${PV}.crt" root-ca.crt
}

pkg_postinst() {
	elog "The DN42 root CA certificate has been installed to:"
	elog "  ${EROOT}/usr/share/ca-certificates/dn42/root-ca.crt"
	elog ""
	elog "It is NOT trusted system-wide by default. This CA is constrained to"
	elog "signing names under .dn42, but you should still enable it"
	elog "deliberately rather than trust it globally without thinking about it."
	elog ""
	elog "To enable it:"
	elog "  1. Add 'dn42/root-ca.crt' to ${EROOT}/etc/ca-certificates.conf"
	elog "  2. Run: ${EROOT}/usr/sbin/update-ca-certificates"
}
