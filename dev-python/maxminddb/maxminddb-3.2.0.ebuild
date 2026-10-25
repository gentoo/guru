# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

TESTS_V="0ee49278e35fd7bdf341ac236edbba20de1aceb9"

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..15} )

inherit distutils-r1

DESCRIPTION="Python MaxMind DB reader extension"
HOMEPAGE="https://github.com/maxmind/MaxMind-DB-Reader-python"
SRC_URI="
	https://github.com/maxmind/MaxMind-DB-Reader-python/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/maxmind/MaxMind-DB/archive/${TESTS_V}.tar.gz -> maxminddb-tests-${TESTS_V}.tar.gz
"

S="${WORKDIR}/MaxMind-DB-Reader-python-${PV}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-libs/libmaxminddb
"

EPYTEST_DESELECT=(
	"tests/reader_test.py::TestReaderInitialization::test_empty_search_tree_is_accepted"
	"tests/reader_test.py::TestReaderInitialization::test_invalid_tree_metadata_is_rejected_on_open"
)

EPYTEST_PLUGINS=()
distutils_enable_tests pytest

src_prepare() {
	rmdir "${S}/tests/data" || die
	ln -s "${WORKDIR}/MaxMind-DB-${TESTS_V}" "${S}/tests/data" || die

	distutils-r1_src_prepare
}

src_compile() {
	export MAXMINDDB_USE_SYSTEM_LIBMAXMINDDB=1

	distutils-r1_src_compile
}

python_test() {
	cp "${BUILD_DIR}/install$(python_get_sitedir)/maxminddb/extension"*.so maxminddb || die
	epytest
}
