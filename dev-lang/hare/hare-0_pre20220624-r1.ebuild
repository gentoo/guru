# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="The Hare systems programming language"
HOMEPAGE="https://harelang.org/"
EGIT_COMMIT="65449ddbbbf39659bfaf84a2cb78510409a4ab7a"
SRC_URI="https://git.sr.ht/~sircmpwn/hare/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${EGIT_COMMIT}"
LICENSE="MPL-2.0 GPL-3"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~arm64 ~riscv"

DEPEND="
	sys-devel/qbe
	dev-lang/harec
"
BDEPEND="
	app-text/scdoc
"
RDEPEND="${DEPEND}"

src_unpack() {
	default
	git-r3_src_unpack
	mkdir "${WORKDIR}/${P}/build" || die
}

src_configure() {
	cp config.example.mk config.mk || die
	sed -i -e 's;^PREFIX=.*;PREFIX=/usr;' config.mk || die
}
