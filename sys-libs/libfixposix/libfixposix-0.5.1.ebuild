# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Thin wrapper over POSIX syscalls"
HOMEPAGE="https://github.com/sionescu/libfixposix"
SRC_URI="https://github.com/sionescu/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Boost-1.0"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="${RDEPEND}"

src_prepare() {
	einfo "Generating autotools files..."
	default
	eautoreconf -i -f
}

src_install() {
	default
	find "${ED}" -name "*.la" -delete || die
}
