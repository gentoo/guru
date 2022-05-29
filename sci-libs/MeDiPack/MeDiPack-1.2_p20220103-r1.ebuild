# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

COMMIT="25f757b4b20372b099190845392a5e08eadf0eb1"

DESCRIPTION='Message Differentiation Package'
HOMEPAGE="
	https://github.com/SciCompKL/MeDiPack
	https://www.scicomp.uni-kl.de/software/medi/
"
SRC_URI="https://github.com/SciCompKL/${PN}/archive/${COMMIT}.tar.gz -> ${PF}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

KEYWORDS="~amd64"
LICENSE='GPL-3'
SLOT="0/${PV}"

RDEPEND="${DEPEND}"
BDEPEND="sys-devel/gsl"

src_prepare() {
	default
	emake clean
}

src_compile() {
	emake all
}

src_install() {
	dodoc README.md
	dodoc doc/*
	insinto "/usr/share/${PN}"
	doins -r generated
	doins -r include
	doins -r src
}
