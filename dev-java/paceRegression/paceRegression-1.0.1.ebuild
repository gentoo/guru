# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EANT_BUILD_TARGET="exejar"
EANT_BUILD_XML="build_package.xml"
EANT_GENTOO_CLASSPATH="weka"
EANT_EXTRA_ARGS="-Dpackage=paceRegression"

inherit java-pkg-2 java-ant-2

DESCRIPTION="Class for building pace regression linear models and using them for prediction"
HOMEPAGE="https://weka.sourceforge.net/doc.packages/paceRegression"
SRC_URI="mirror://sourceforge/weka/${PN}${PV}.zip"
S="${WORKDIR}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

CDEPEND=">=dev-util/weka-3.7.1:0"
DEPEND="
	${CDEPEND}
	>=virtual/jdk-1.8:*
"
RDEPEND="
	${CDEPEND}
	>=virtual/jre-1.8:*
"
BDEPEND="app-arch/unzip"

PATCHES=( "${FILESDIR}/${P}-no-build-docs.patch" )

src_prepare() {
	java-pkg_clean
	default
	java-ant_bsfix_files build_package.xml
	java-ant_rewrite-classpath build_package.xml
}

src_install() {
	java-pkg_dojar "dist/${PN}.jar"
}
