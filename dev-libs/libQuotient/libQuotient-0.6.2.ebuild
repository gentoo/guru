# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="A Qt5 library to write cross-platform clients for Matrix"
HOMEPAGE="https://github.com/quotient-im/libQuotient"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/quotient-im/${PN}"
else
	SRC_URI="https://github.com/quotient-im/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="LGPL-2.1"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

DEPEND="
	dev-qt/qtgui
	dev-qt/qtnetwork
	dev-qt/qtmultimedia
"
RDEPEND="${DEPEND}"
