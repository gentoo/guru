# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module systemd

DESCRIPTION="Easy web analytics without tracking of personal data"
HOMEPAGE="
	https://www.goatcounter.com
	https://github.com/arp242/goatcounter
"
SRC_URI="https://github.com/arp242/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/gentoo-golang-dist/${PN}/releases/download/v${PV}/${P}-vendor.tar.xz
"

LICENSE="EUPL-1.2 ISC MIT OFL-1.1"
LICENSE+=" Apache-2.0 BSD BSD-2 MIT public-domain"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="acct-user/goatcounter"
BDEPEND=">=dev-lang/go-1.24.4"

DOCS=( CHANGELOG.md README.md docs/. )

src_compile() {
	ego build -ldflags="-X zgo.at/goatcounter/v2.Version=${PV}" ./cmd/goatcounter
}

src_test() {
	ego test -vet=off ./...
}

src_install() {
	dobin goatcounter
	einstalldocs

	keepdir /var/db/goatcounter
	fowners goatcounter:goatcounter /var/db/goatcounter
	fperms 750 /var/db/goatcounter

	newinitd "${FILESDIR}"/goatcounter.initd goatcounter
	newconfd "${FILESDIR}"/goatcounter.confd goatcounter

	systemd_dounit "${FILESDIR}"/goatcounter.service
}
