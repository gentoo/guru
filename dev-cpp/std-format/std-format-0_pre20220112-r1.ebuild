# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

COMMIT="45296602ad78a804411e7c3b617e13759f38e4e7"

DESCRIPTION="A simple polyfill allowing you to use std::format"
HOMEPAGE="https://gitlab.com/ananicy-cpp/stl-polyfills/std-format"
SRC_URI="https://gitlab.com/ananicy-cpp/stl-polyfills/${PN}/-/archive/${COMMIT}/${PN}-${COMMIT}.tar.bz2"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="CC0-1.0"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="test"

DEPEND="dev-libs/libfmt"

RESTRICT="!test? ( test )"

src_configure() {
	local mycmakeargs=(
		-DBUILD_TESTING=$(usex test)
	)
	cmake_src_configure
}
