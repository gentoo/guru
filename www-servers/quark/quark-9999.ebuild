# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit git-r3
DESCRIPTION="A small, GET-only static HTTP server"
HOMEPAGE="https://tools.suckless.org/quark/"
EGIT_REPO_URI="https://git.suckless.org/quark/"
S="${WORKDIR}/${P}"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""

DEPEND="${RDEPEND}"
BDEPEND=""
src_configure() {
	sed -in 's/local//' config.mk
	sed -in 's/d -s/d/' config.mk
	sed -in 's/CF/#CF/' config.mk
	sed -in 's/CPP/#CPP/' config.mk
}
