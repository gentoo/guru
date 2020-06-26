# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="Tool for annotating images"
HOMEPAGE="https://github.com/ksnip/kImageAnnotator"
MY_PN=kImageAnnotator
MY_P="${MY_PN}-${PV}"
SRC_URI="https://github.com/ksnip/${MY_PN}/archive/v${PV}.tar.gz -> ${MY_P}.tar.gz"

LICENSE="LGPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-qt/qtsvg:5
		>=x11-libs/kcolorpicker-0.1.4"
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}/${MY_P}"

src_prepare() {
	default
	eapply "${FILESDIR}"/fix-undo-command-delete-items-that-are-required.patch
	eapply "${FILESDIR}"/include-gnuinstalldirs-before-use.patch
	cmake_src_prepare
}
