# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# TODO: add tests, doc
# TODO: add optional +xapian USE

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )

inherit meson python-any-r1

TEST_DATA_V="0.9.0"

DESCRIPTION="ZIM file format: an offline storage solution for content coming from the Web"
HOMEPAGE="https://wiki.openzim.org/wiki/OpenZIM"
SRC_URI="
	https://github.com/openzim/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz
	test? (
		https://github.com/openzim/zim-testing-suite/releases/download/${TEST_DATA_V}/zim-testing-suite-${TEST_DATA_V}.tar.gz -> ${P}-test_data.tar.gz
	)
"

LICENSE="GPL-2"
SLOT="0/9.5"
KEYWORDS="~amd64"

IUSE="test"

RDEPEND="
	app-arch/lzma
	app-arch/xz-utils
	app-arch/zstd:=
	dev-libs/icu:=
	dev-libs/xapian:=
"
DEPEND="${RDEPEND}"
BDEPEND="
	test? (
		dev-cpp/gtest
	)
	${PYTHON_DEPS}"

src_prepare() {
	default

	sed -i "s/, 'suggestion'//g" test/meson.build || die
	sed -i "/archive/d" test/meson.build || die
}

src_configure() {
	local emesonargs=(
		$(meson_use test tests)
		-Dtest_data_dir="${WORKDIR}/zim-testing-suite-${TEST_DATA_V}"
	)
	meson_src_configure
}
