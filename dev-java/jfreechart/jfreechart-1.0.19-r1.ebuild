# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-ant-2

DESCRIPTION="JFreeChart is a free Java class library for generating charts"
HOMEPAGE="http://www.jfree.org/jfreechart"
SRC_URI="mirror://sourceforge/${PN}/${P}.zip"

LICENSE="LGPL-2.1"
SLOT="1.0"
KEYWORDS="~amd64"
IUSE="test"

CDEPEND="
	dev-java/hamcrest-core:1.3
	>=dev-java/jcommon-1.0.23:1.0
	dev-java/jfreesvg:3
	dev-java/orson-charts:1
	dev-java/orsonpdf:1
	java-virtuals/servlet-api:3.0
"
RDEPEND="
	${CDEPEND}
	>=virtual/jre-1.8:*
"
DEPEND="
	${CDEPEND}
	test? (
		dev-java/ant-junit:0
		dev-java/junit:4
	)
	app-arch/unzip
	>=virtual/jdk-1.8:*
"

RESTRICT="test"
PATCHES=(
	"${FILESDIR}/${PN}-1.0.19-build.xml.patch"
	"${FILESDIR}/${PN}-1.0.19-fix-TimeSeriesCollectionTest.patch"
)

JAVA_ANT_ENCODING="ISO-8859-1"
JAVA_ANT_REWRITE_CLASSPATH="yes"
EANT_BUILD_XML="ant/build.xml"
EANT_BUILD_TARGET="compile-experimental"
EANT_DOC_TARGET="javadoc"
EANT_GENTOO_CLASSPATH="
	hamcrest-core-1.3
	jfreesvg-3
	jcommon-1.0
	orsonpdf-1
	orson-charts-1
	servlet-api-3.0
"

src_prepare() {
	java-pkg_clean
	default
	pushd lib || die
	java-pkg_jar-from jfreesvg-3 jfreesvg.jar jfreesvg-3.2.jar
	java-pkg_jar-from orson-charts-1 orsoncharts.jar orsoncharts-1.4-eval-nofx.jar
	java-pkg_jar-from orsonpdf-1 orsonpdf.jar orsonpdf-1.6-eval.jar
	java-pkg_jar-from --virtual servlet-api-3.0 servlet-api.jar servlet.jar
	java-pkg_jar-from jcommon-1.0 jcommon.jar jcommon-1.0.23.jar
	java-pkg_jar-from hamcrest-core-1.3 hamcrest-core.jar hamcrest-core-1.3.jar
	popd || die
}

src_install() {
	java-pkg_newjar "lib/${P}.jar" "${PN}.jar"
	java-pkg_newjar "lib/${P}-experimental.jar" "${PN}-experimental.jar"

	dodoc README.txt ChangeLog NEWS

	use doc && java-pkg_dojavadoc javadoc
	use source && java-pkg_dosrc source/org
}
