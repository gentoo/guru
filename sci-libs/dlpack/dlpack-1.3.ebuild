# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Common in-memory tensor structure"
HOMEPAGE="https://github.com/dmlc/dlpack"
SRC_URI="https://github.com/dmlc/dlpack/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc test"
RESTRICT="!test? ( test )"

BDEPEND="doc? (
	app-text/doxygen
	dev-python/breathe
	dev-python/pydata-sphinx-theme
	dev-python/sphinx
)"

PATCHES=(
	"${FILESDIR}/${PN}-1.1-dont-turn-warnings-into-errors-when-building-docs.patch"
)

src_configure() {
	local mycmakeargs=(
		-DBUILD_DOCS=$(usex doc)
		-DBUILD_MOCK=$(usex test)
	)

	cmake_src_configure
}
