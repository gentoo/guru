# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=scikit-build-core
PYTHON_COMPAT=( python3_{12..15} )
EPYTEST_PLUGINS=()

inherit java-pkg-2 distutils-r1

DESCRIPTION="Bridge to allow Python programs full access to Java class libraries"
HOMEPAGE="https://github.com/jpype-project/jpype/"
SRC_URI="
	https://github.com/jpype-project/jpype/archive/refs/tags/v${PV}.tar.gz
		-> ${P}.gh.tar.gz
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/packaging[${PYTHON_USEDEP}]
	>=virtual/jre-11:*
"

DEPEND=">=virtual/jdk-11:*"

BDEPEND="
	${DEPEND}
	>=dev-python/scikit-build-core-0.9[${PYTHON_USEDEP}]
	dev-java/ant
	test? (
		dev-python/jedi[${PYTHON_USEDEP}]
		dev-python/numpy[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

PATCHES=(
	"${FILESDIR}/${P}-java-release.patch"
	"${FILESDIR}/${P}-jar-location.patch"
)

python_compile() {
	local DISTUTILS_ARGS=( -DBUILD_TEST_HARNESS=$(usex test ON OFF) )
	distutils-r1_python_compile
}

python_test() {
	cd test || die

	epytest jpypetest --checkjni \
		--ignore=jpypetest/test_sql_h2.py \
		--ignore=jpypetest/test_sql_hsqldb.py \
		--ignore=jpypetest/test_sql_sqlite.py
}
