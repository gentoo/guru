# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

COMMIT="b31353849855e1c1ab3fefb6f705f6ccb148c1b8"
JAVA_PKG_IUSE="source"

inherit java-pkg-2 java-pkg-simple

DESCRIPTION="JFreeSVG is a fast, light-weight, vector graphics library for the Java platform"
HOMEPAGE="
	https://www.jfree.org/jfreesvg/
	https://github.com/jfree/jfreesvg
"
SRC_URI="https://github.com/jfree/${PN}/archive/${COMMIT}.tar.gz -> ${PF}.gh.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="GPL-3+"
SLOT="3"
KEYWORDS="~amd64"
IUSE="debug"

DEPEND=">=virtual/jdk-1.8:*"
RDEPEND=">=virtual/jre-1.8:*"

JAVA_SRC_DIR="src/main/java/org/jfree/graphics2d"

src_prepare() {
	java-pkg_clean
	default
}

src_install() {
	java-pkg_dojar "${PN}.jar"
	dodoc README.md
	use source && java-pkg_dosrc src/main/java
}
