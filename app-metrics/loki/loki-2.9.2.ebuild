# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit go-module

DESCRIPTION="Like Prometheus, but for logs"
HOMEPAGE="https://github.com/grafana/loki"
SRC_URI="https://github.com/grafana/loki/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64"

COMMON_DEPEND="acct-group/loki
	acct-user/loki"
DEPEND="${COMMON_DEPEND}"
RDEPEND="${COMMON_DEPEND}"

src_compile() {
	ego build ./cmd/loki
}

src_install() {
	# Install the loki binary into /usr/bin
	insinto /usr/bin
	dobin loki
}
