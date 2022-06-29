# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-ant-2

DESCRIPTION="Java(TM) Binding fot the OpenGL(TM) API"
HOMEPAGE="
	https://jogamp.org/jogl/www/
	https://github.com/sgothel/jogl
"
SRC_URI="https://github.com/sgothel/jogl/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="BSD"
SLOT="2.3"
KEYWORDS="~amd64"
IUSE="cg"

CDEPEND="
	dev-java/antlr:0
	dev-java/ant-core:0
	~dev-java/gluegen-${PV}:${SLOT}
	dev-java/swt:3.7
	virtual/opengl
	x11-libs/libX11
	x11-libs/libXxf86vm
	cg? ( media-gfx/nvidia-cg-toolkit )
"
RDEPEND="
	${CDEPEND}
	>=virtual/jre-1.8:*
"
DEPEND="
	${CDEPEND}
	>=virtual/jdk-1.8:*
"
BDEPEND="dev-vcs/git"

EANT_BUILD_TARGET="init build.nativewindow build.jogl build.newt build.oculusvr one.dir tag.build"
EANT_BUILD_XML="make/build.xml"
EANT_DOC_TARGET=""
EANT_GENTOO_CLASSPATH="gluegen-${SLOT},antlr,ant-core,swt-3.7"
EANT_GENTOO_CLASSPATH_EXTRA="${S}/build/${PN}/*.jar:${S}/build/nativewindow/*.jar"
EANT_NEEDS_TOOLS="yes"
JAVA_ANT_REWRITE_CLASSPATH="yes"
JAVA_PKG_BSFIX_NAME+=" build-jogl.xml build-nativewindow.xml build-newt.xml"
WANT_ANT_TASKS="ant-antlr ant-contrib dev-java/cpptasks:0"

# upstream has a crude way to call the junit tests, which cause a lot of trouble to pass
# our test classpath...
RESTRICT="test"

src_prepare() {
	default
	rm -r make/lib || die
	java-pkg_clean

	# Empty filesets are never out of date!
	sed -i -e 's/<outofdate>/<outofdate force="true">/' make/build*xml || die

	EANT_EXTRA_ARGS+=" -Dcommon.gluegen.build.done=true"
	EANT_EXTRA_ARGS+=" -Dgluegen.root=/usr/share/gluegen-${SLOT}/"
	EANT_EXTRA_ARGS+=" -Dgluegen.jar=$(java-pkg_getjar gluegen-${SLOT} gluegen.jar)"
	EANT_EXTRA_ARGS+=" -Dgluegen-rt.jar=$(java-pkg_getjar gluegen-${SLOT} gluegen-rt.jar)"

	use cg && EANT_EXTRA_ARGS+=" -Djogl.cg=1 -Dx11.cg.lib=/usr/lib"
	export EANT_EXTRA_ARGS

	#it want a git repo
	git init || die
	git config --global user.email "you@example.com" || die
	git config --global user.name "Your Name" || die
	git add . || die
	git commit -m 'init' || die
}

src_install() {
	java-pkg_dojar build/jar/*.jar
	java-pkg_doso build/lib/*.so

	use doc && dodoc -r doc
	use source && java-pkg_dosrc src/jogl/classes/*
}
