# Copyright 2019-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Your One Get Remaining Time library"
HOMEPAGE="https://github.com/LLNL/libyogrt"
SRC_URI="https://github.com/LLNL/libyogrt/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE="slurm" #lsf moab lcrm

RDEPEND="slurm? ( sys-cluster/slurm )"
DEPEND="${RDEPEND}"

src_prepare() {
	default
	AT_M4DIR="config" eautoreconf
}

src_configure() {
	local myconf

	use slurm && myconf+=( "--with-slurm=${EPREFIX}/usr" )

	econf "${myconf[@]}"
}

src_install() {
	default
	find "${ED}" -name '*.la' -delete || die
}
