# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

COMMIT="fffb613071cb44319c0d6b743a8d6eafc2ed2ad7"

DESCRIPTION="Fast Static Symbol Table: fast text compression that allows random access"
HOMEPAGE="https://github.com/cwida/fsst"
SRC_URI="https://github.com/cwida/fsst/archive/${COMMIT}.tar.gz -> ${P}.gh.tar.gz"

S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"

BDEPEND="app-admin/chrpath"
RDEPEND="${DEPEND}"

src_install() {
	chrpath -d "${BUILD_DIR}/fsst" || die

	doheader fsst.h libfsst.hpp
	dolib.so "${BUILD_DIR}/libfsst.so"
	dobin "${BUILD_DIR}/fsst"
	dodoc -r README.md fsst-presentation* fsstcompression.pdf
}
