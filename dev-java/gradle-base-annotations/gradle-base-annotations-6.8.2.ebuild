# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-pkg-simple

DESCRIPTION="Build automation tool for JVM Languages, C(++), etc."
HOMEPAGE="https://gradle.org"
SRC_URI="https://github.com/gradle/gradle/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="6.8"
KEYWORDS="~amd64 ~x86"

CDEPEND="dev-java/jsr305"

RDEPEND=">=virtual/jre-1.8
${CDEPEND}"
DEPEND=">=virtual/jdk-1.8
${CDEPEND}"

S="${WORKDIR}/gradle-${PV}"
JAVA_SRC_DIR="subprojects/base-annotations/src/main/java"
JAVA_GENTOO_CLASSPATH="jsr305"
RESTRICT="test"
