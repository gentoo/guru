# Copyright 2019-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

COMMIT="7375ba5bb0df87c68e58ad15e9e5e351ae020c08"

DESCRIPTION="A framework for bootstrapping extreme scale software systems"
HOMEPAGE="http://www.paradyn.org/mrnet"
SRC_URI="https://github.com/dyninst/mrnet/archive/${COMMIT}.tar.gz -> ${P/libi/mrnet}.tar.gz"
S="${WORKDIR}/mrnet-${COMMIT}/external/libi"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE="slurm"

DEPEND="
	sys-cluster/launchmon
	sys-cluster/mrnet
"
DEPEND="
	${RDEPEND}
	slurm? ( sys-cluster/slurm )
"

PATCHES=( "${FILESDIR}/${PN}-create-libdir.patch" )

src_configure() {
	local myconf=(
		--enable-shared
		--with-launchmon="${EPREFIX}/usr"
		--with-xplat="${EPREFIX}/usr"
	)

	use slurm && myconf+=( "--with-libi-startup=slurm" )

	econf "${myconf[@]}"
}

src_install() {
	dolib.so ../../build/*/lib/liblibi.so
	insinto /usr/include
	doins -r include/libi
}
