# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module systemd

DESCRIPTION="Weighs the soul of incoming HTTP requests to stop AI crawlers"
HOMEPAGE="
	https://anubis.techaro.lol/
	https://github.com/TecharoHQ/anubis
"
SRC_URI="https://github.com/TecharoHQ/anubis/releases/download/v${PV}/anubis-src-vendor-npm-${PV}.tar.gz"
S="${WORKDIR}/anubis-src-vendor-npm-${PV}"

LICENSE="Apache-2.0 BSD MIT OFL-1.1"
SLOT="0"
KEYWORDS="~amd64"

DOCS=( README.md data docs/docs )

RDEPEND="acct-user/anubis"

src_prepare() {
	default
	find docs/docs -name _category_.json -delete || die
}

src_compile() {
	emake prebaked-build
}

src_test() {
	local -x DONT_USE_NETWORK=1
	ego test ./... -skip TestIntegrationGetOGTags_UnixSocket
}

src_install() {
	dobin var/anubis
	newbin var/robots2policy anubis-robots2policy
	systemd_dounit run/anubis@.service

	newinitd run/openrc/anubis.initd anubis
	newconfd run/openrc/anubis.confd anubis

	insinto /etc/anubis
	doins run/default.env

	find data -name '*.go' -delete || die
	einstalldocs
}
