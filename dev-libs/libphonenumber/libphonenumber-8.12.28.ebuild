# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="library for parsing, formatting, and validating international phone numbers"
HOMEPAGE="https://github.com/google/libphonenumber"
SRC_URI="https://github.com/google/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

KEYWORDS="~amd64 ~arm ~arm64 ~x86"

LICENSE="Apache-2.0"

SLOT="0"
IUSE=""

DEPEND="dev-libs/icu
		dev-libs/protobuf
		dev-libs/boost
"
RDEPEND="${DEPEND}"

BDEPEND="dev-cpp/gtest
		virtual/jdk
"

RESTRICT+=" test" # bug 668872

CMAKE_USE_DIR=${S}/cpp

CMAKE_MAKEFILE_GENERATOR=emake
