# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

JAVA_PKG_IUSE="doc source test"

inherit java-pkg-2 java-pkg-simple

jsoft_hash="75c3a5d1ab1322ce4dde0b5994d6f9f6ff820529"

DESCRIPTION="RARS -- RISC-V Assembler and Runtime Simulator"
HOMEPAGE="https://github.com/TheThirdOne/rars"
SRC_URI="
	https://github.com/TheThirdOne/rars/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz
	https://github.com/TheThirdOne/JSoftFloat/archive/${jsoft_hash}.tar.gz -> JSoftFloat-75c3a5d.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
S="${WORKDIR}/${P}"

CP_DEPEND=""

RDEPEND=">=virtual/jre-1.8:*
	${CP_DEPEND}"
DEPEND=">=virtual/jdk-1.8:*
	${CP_DEPEND}"

src_unpack() {
	default
	mv "${WORKDIR}/JSoftFloat-${jsoft_hash}" "${S}/src/jsoftfloat"
}

src_prepare() {
	default
	java-pkg_clean
}

src_compile() {
	# Using the build-jar.sh script
	cd "${S}"
	mkdir -p build
	find src -name "*.java" | xargs javac -d build
	find src -type f -not -name "*.java" -exec cp --parents {} build \;
	cp -rf build/src/* build
	rm -r build/src
	cp README.md License.txt build
	cd build
	jar cfm ../rars.jar ./META-INF/MANIFEST.MF *
}

src_install() {
	java-pkg_dojar "${S}/rars.jar"
	mkdir -p "${D}/usr/bin"
	echo "#!/bin/bash" > "${D}/usr/bin/rars"
	echo "java -jar /usr/share/rars/lib/rars.jar" >> "${D}/usr/bin/rars"
	chmod 755 "${D}/usr/bin/rars"
}
