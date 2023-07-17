# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Tool to communicate with Qualcomm System On a Chip bootroms"
HOMEPAGE="https://github.com/andersson/qdl"
SRC_URI="https://github.com/andersson/qdl/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD-3"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="virtual/libudev
		dev-libs/libxml2
"

src_install() {
	emake DESTDIR="${D}" prefix="${EPREFIX}"/usr install

	dodoc README
	insinto "/usr/share/${PN}"
	doins LICENSE
}
