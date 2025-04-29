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

DOCS=(
	# from yeetfile.js
	README.md
	docs/docs/CHANGELOG.md
	docs/docs/admin/policies.mdx
	docs/docs/admin/native-install.mdx
	data/botPolicies.{json,yaml}
)

src_compile() {
	emake prebaked-build
}

src_test() {
	local -x DONT_USE_NETWORK=1
	ego test ./... || die
}

src_install() {
	dobin var/anubis
	systemd_dounit run/anubis@.service

	newinitd "${FILESDIR}"/anubis.initd anubis
	newconfd "${FILESDIR}"/anubis.confd anubis

	insinto /etc/anubis
	doins run/default.env

	einstalldocs
}
