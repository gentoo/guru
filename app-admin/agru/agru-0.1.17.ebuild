# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit go-module

DESCRIPTION="A tool for managing GitLab groups and projects"
HOMEPAGE="https://github.com/etkecc/agru"

SRC_URI="
	https://github.com/etkecc/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://xwaretech.info/agru-${PV}-deps.tar.xz
"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

src_compile() {
	cd "${S}/cmd/agru" || die
	ego build -o agru
}

src_install() {
	cd "${S}/cmd/agru" || die
	dobin agru
}
