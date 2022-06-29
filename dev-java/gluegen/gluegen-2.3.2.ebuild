# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

JAVA_PKG_IUSE="doc source test"

inherit java-pkg-2 java-ant-2 toolchain-funcs

DESCRIPTION="Automatically generate the JNI code necessary to call C libraries"
HOMEPAGE="
	https://jogamp.org/gluegen/www/
	https://github.com/sgothel/gluegen
"
SRC_URI="
	https://github.com/sgothel/gluegen/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz
	https://github.com/sgothel/jcpp/archive/refs/tags/v${PV}.tar.gz -> gluegen-jcpp-${PV}.gh.tar.gz
"
#TODO: unbundle jcpp if possible

LICENSE="BSD Apache-2.0"
SLOT="2.3"
KEYWORDS="~amd64"

COMMON_DEP="
	dev-java/ant-core:0
	dev-java/antlr:0
	dev-java/jsr305:0
"
RDEPEND="
	${COMMON_DEP}
	>=virtual/jre-1.8:*
"
DEPEND="
	${COMMON_DEP}
	>=virtual/jdk-1.8:*
	dev-java/cpptasks:0
	test? (
		dev-java/junit:4
		dev-java/ant-junit4
	)
"
BDEPEND="dev-vcs/git"

PATCHES=(
	"${FILESDIR}/${PN}-2.2.4-dont-copy-jars.patch"
	"${FILESDIR}/${PN}-2.2.4-dont-strip.patch"
	"${FILESDIR}/${PN}-2.2.4-dont-test-archive.patch"
	"${FILESDIR}/${P}-remove-static-lib.patch"
	"${FILESDIR}/${P}-respect-flags.patch"
)
EANT_BUILD_TARGET="all.no_junit"
EANT_BUILD_XML="make/build.xml"
EANT_DOC_TARGET=""
EANT_EXTRA_ARGS="-Dc.strip.libraries=false"
EANT_GENTOO_CLASSPATH="antlr,ant-core,jsr305"
EANT_GENTOO_CLASSPATH_EXTRA="${S}/build/${PN}{,-rt}.jar"
EANT_NEEDS_TOOLS="yes"
EANT_TEST_GENTOO_CLASSPATH="${EANT_GENTOO_CLASSPATH},junit-4"
EANT_TEST_TARGET="junit.run"
JAVA_ANT_REWRITE_CLASSPATH="yes"
WANT_ANT_TASKS="ant-antlr ant-contrib dev-java/cpptasks:0"

src_prepare() {
	tc-export CC
	mv "${WORKDIR}"/jcpp-${PV}/* jcpp/ || die
	rm -rf make/lib || die
	default
	java-ant_bsfix_files "${S}/make/build-test.xml" "${S}/make/jogamp-env.xml"

	#it want a git repo
	git init || die
	git config --global user.email "you@example.com" || die
	git config --global user.name "Your Name" || die
	git add . || die
	git commit -m 'init' || die
}

src_test() {
	EANT_TASKS="ant-junit4" java-pkg-2_src_test
}

src_install() {
	java-pkg_dojar build/${PN}{,-rt}.jar
	java-pkg_doso build/obj/*.so

	use doc && dodoc -r doc/manual
	use source && java-pkg_dosrc src/java/*

	# for building jogl
	insinto /usr/share/${PN}-${SLOT}/make
	doins -r make/*
	insinto /usr/share/${PN}-${SLOT}/build
	doins build/artifact.properties
}
