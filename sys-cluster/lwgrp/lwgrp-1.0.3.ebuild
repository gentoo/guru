# Copyright 2019-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

DESCRIPTION="Light-weight Group Library"
HOMEPAGE="https://github.com/LLNL/lwgrp"
SRC_URI="https://github.com/LLNL/lwgrp/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="mpianysource"

RDEPEND="virtual/mpi"
DEPEND="${RDEPEND}"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		$(use_enable mpianysource)
	)
	econf "${myconf[@]}"
}

src_install() {
	default
	rm -r "${ED}/usr/share/${PN}" || die
	find "${ED}" -name '*.la' -delete || die
	find "${ED}" -name '*.a' -delete || die
}
