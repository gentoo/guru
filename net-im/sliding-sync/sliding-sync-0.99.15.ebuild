# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module systemd

DESCRIPTION="Proxy implementation of MSC3575's sync protocol."
HOMEPAGE="https://github.com/matrix-org/sliding-sync"
SRC_URI="
	https://github.com/matrix-org/sliding-sync/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz
	https://jroy.ca/dist/${P}-deps.tar.xz
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-db/postgresql"
DEPEND="${RDEPEND}"

src_compile() {
	ego build "${S}/cmd/syncv3"
}

src_install() {
	dobin syncv3

	newinitd "${FILESDIR}"/sliding-sync.initd sliding-sync
	newconfd "${FILESDIR}"/sliding-sync.confd sliding-sync
	systemd_dounit "${FILESDIR}"/sliding-sync.service
}
