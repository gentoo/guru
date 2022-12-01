# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit crystal-utils multiprocessing toolchain-funcs

DESCRIPTION="Small helper tools to aid installing Crystal packages in Gentoo"
HOMEPAGE="https://wiki.gentoo.org/wiki/No_homepage"
S="${WORKDIR}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-libs/boehm-gc
	dev-libs/libevent:=
	dev-libs/libpcre:3
	dev-libs/libyaml
"
DEPEND="${RDEPEND}"
BDEPEND="${CRYSTAL_DEPS}"

QA_FLAGS_IGNORED='.*'

src_configure() {
	crystal_configure
	tc-export CC
}

src_compile() {
	for prog in "${FILESDIR}"/${PV}/gshards-*.cr; do
		ecrystal build "${prog}" --verbose --threads=$(makeopts_jobs)
	done
}

src_install() {
	dobin gshards-*
}
