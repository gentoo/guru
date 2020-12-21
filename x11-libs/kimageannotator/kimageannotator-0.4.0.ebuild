# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="Tool for annotating images"
HOMEPAGE="https://github.com/ksnip/kImageAnnotator"
SRC_URI="https://github.com/ksnip/kImageAnnotator/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="
	dev-qt/qtsvg:5
	>=x11-libs/kcolorpicker-0.1.4
"
RDEPEND="${DEPEND}"

S="${WORKDIR}/kImageAnnotator-${PV}"
