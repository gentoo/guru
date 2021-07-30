# Copyright 2019-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

DESCRIPTION="Datatype Compare Library for sorting and ranking distributed data using MPI"
HOMEPAGE="https://github.com/LLNL/dtcmp"
SRC_URI="https://github.com/LLNL/dtcmp/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	sys-cluster/lwgrp
	virtual/mpi
"
DEPEND="${RDEPEND}"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		--with-lwgrp="${EPREFIX}/usr"
	)
	econf "${myconf[@]}"
}

src_install() {
	default
	rm -r "${ED}/usr/share/${PN}" || die
	find "${ED}" -name '*.la' -delete || die
	find "${ED}" -name '*.a' -delete || die
}
