# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit go-module

DESCRIPTION="A tool for managing GitLab groups and projects"
HOMEPAGE="https://gitlab.com/etke.cc/tools/agru"

SRC_URI="https://gitlab.com/etke.cc/tools/agru/-/archive/v${PV}/v${PV}.tar.bz2 -> ${P}.tar.bz2
https://xwaretech.info/agru-${PV}-deps.tar.xz"

S="${WORKDIR}/${PN}-v${PV}-d6a2bd6d8a4fca3dbb0201c020e4f70ce9a90c39"

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
