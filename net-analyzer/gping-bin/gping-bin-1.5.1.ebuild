# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Ping with graph"
HOMEPAGE="https://github.com/orf/gping"
SRC_URI="https://github.com/orf/${PN%-bin}/releases/download/${PN%-bin}-v${PV}/gping-Linux-x86_64.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
QA_FLAGS_IGNORED="usr/bin/gping"

S=${WORKDIR}

src_compile() { :; }

src_install() {
	newbin ${PN%-bin} gping
}
