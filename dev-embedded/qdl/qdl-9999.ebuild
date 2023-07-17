# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="Tool to communicate with Qualcomm System On a Chip bootroms"
HOMEPAGE="https://github.com/andersson/qdl"
EGIT_REPO_URI="https://github.com/andersson/qdl.git"

LICENSE="BSD-3"
SLOT="0"

BDEPEND="virtual/libudev
		dev-libs/libxml2
"

src_install() {
	emake DESTDIR="${D}" prefix="${EPREFIX}"/usr install

	dodoc README
	insinto "/usr/share/${PN}"
	doins LICENSE
}
