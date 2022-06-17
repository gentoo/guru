# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MYPN="mesp"

inherit java-pkg-2 java-pkg-simple

DESCRIPTION="Parser for mathematical expressions written in Java"
HOMEPAGE="https://sourceforge.net/projects/expression-tree"
SRC_URI="mirror://sourceforge/${PN}/${MYPN}${PV}.zip"
S="${WORKDIR}/${MYPN}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="test"

DEPEND=">=virtual/jdk-1.8:*"
RDEPEND=">=virtual/jre-1.8:*"
BDEPEND="app-arch/unzip"

JAVA_JAR_FILENAME="Mesp.jar"
JAVA_SRC_DIR=(
	"src/com/graphbuilder/struc"
	"src/com/graphbuilder/math/func"
	"src/com/graphbuilder/math"
)

src_prepare() {
	java-pkg_clean
	default
}

src_install() {
	java-pkg_dojar Mesp.jar
	dodoc {readme,release-notes}.txt
}
