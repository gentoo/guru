# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EANT_BUILD_TARGET="compile"
EANT_BUILD_XML="ant/build.xml"
EANT_DOC_TARGET="javadocs"
EANT_NEEDS_TOOLS="true"
JAVA_ANT_REWRITE_CLASSPATH="true"
JAVA_PKG_IUSE="doc source test"
MY_P="${PN}-$(ver_rs 3 -)"

inherit java-pkg-2 java-ant-2

DESCRIPTION="A collection of useful classes used by JFreeChart, JFreeReport and others"
HOMEPAGE="
	https://www.jfree.org/jcommon
	https://github.com/jfree/jcommon
"
SRC_URI="https://github.com/jfree/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"
#S="${WORKDIR}/${MY_P}"

LICENSE="LGPL-2"
SLOT="1.0"
KEYWORDS="~amd64"

DEPEND="
	>=virtual/jdk-1.8:*
	test? ( dev-java/junit:4 )
"
RDEPEND=">=virtual/jre-1.8:*"
BDEPEND="app-arch/unzip"

src_prepare() {
	java-pkg_clean
	default
}

src_install() {
	java-pkg_newjar ${P}.jar ${PN}.jar
	dodoc README.md
	use doc && java-pkg_dojavadoc javadoc
	use source && java-pkg_dosrc src/main/java/com src/main/java/org
}
