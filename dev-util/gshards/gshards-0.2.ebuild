# Copyright 2022-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit crystal-utils multiprocessing toolchain-funcs

DESCRIPTION="Small helper tools to aid installing Crystal packages in Gentoo"
HOMEPAGE="https://git.sysrq.in/gshards/"
SRC_URI="https://git.sr.ht/~cyber/${PN}/archive/${PV}.tar.gz -> ${P}.srht.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-libs/boehm-gc
	dev-libs/libevent:=
	dev-libs/libpcre2:=
	dev-libs/libyaml
"
DEPEND="${RDEPEND}"
BDEPEND="${CRYSTAL_DEPS}"

QA_FLAGS_IGNORED='.*'

src_configure() {
	tc-export CC
	export CRFLAGS="--threads=$(makeopts_jobs) --verbose"

	crystal_configure
}

src_install() {
	emake PREFIX="${EPREFIX}/usr" DESTDIR="${D}" install
}
