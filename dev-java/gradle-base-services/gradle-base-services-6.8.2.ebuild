# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-pkg-simple

MY_P="gradle-${PV}"

DESCRIPTION="Build automation tool for JVM Languages, C(++), etc."
HOMEPAGE="https://gradle.org"
SRC_URI="https://github.com/gradle/gradle/archive/v${PV}.tar.gz -> ${MY_P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="6.8"
KEYWORDS="~amd64"

CDEPEND="dev-java/javax-inject:0
dev-java/slf4j-api:0
dev-java/guava:20
dev-java/commons-lang:2.1
dev-java/commons-io:1
dev-java/asm:7
dev-java/gradle-base-annotations:${SLOT}
dev-java/gradle-hashing:${SLOT}
dev-java/gradle-build-operations:${SLOT}"

JDK_DEPEND="dev-java/openjdk:11
dev-java/openjdk-bin:11"

RDEPEND="|| ( dev-java/openjdk-jre-bin:11 ${JDK_DEPEND} )
${CDEPEND}"
DEPEND="|| ( ${JDK_DEPEND} )
${CDEPEND}"

MY_PN="${PN/gradle-/}"
S="${WORKDIR}/gradle-${PV}"
JAVA_SRC_DIR="subprojects/${MY_PN}/src/main/java"
JAVA_GENTOO_CLASSPATH="javax-inject
slf4j-api
guava-20
commons-lang-2.1
commons-io-1
asm-7
gradle-base-annotations-${SLOT}
gradle-hashing-${SLOT}
gradle-build-operations-${SLOT}"
JAVA_PKG_WANT_TARGET=11
JAVA_PKG_WANT_SOURCE=11
JAVA_PKG_WANT_BUILD_VM="openjdk-bin-11 openjdk-11"
RESTRICT="test"
