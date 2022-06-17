# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EANT_BUILD_TARGET="runtimejar"
EANT_TEST_TARGET="test"
JAVA_ANT_REWRITE_CLASSPATH="true"
JAVA_PKG_IUSE="doc"

inherit java-pkg-2 java-ant-2

DESCRIPTION="Command-line argument parsing library in Java"
HOMEPAGE="https://github.com/purcell/jargs"
SRC_URI="mirror://sourceforge/${PN}/${P}.zip"
S="${WORKDIR}/${P}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc test"

RESTRICT="!test? ( test )"

DEPEND="
	>=virtual/jdk-1.8:*
	dev-java/junit:4
"
RDEPEND=">=virtual/jre-1.8:*"
BDEPEND="app-arch/unzip"

src_prepare() {
	sed -e "s|/usr/share/java/junit.jar|/usr/share/junit-4/lib/junit.jar|g" -i build.xml || die
	java-pkg_clean
	default
}

src_install() {
	dodoc README
	java-pkg_newjar lib/jargs.jar
	use doc && java-pkg_dojavadoc target/site/apidocs
}
