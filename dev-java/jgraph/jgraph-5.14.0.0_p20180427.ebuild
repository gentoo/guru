# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

COMMIT="b8e7eb81188ebfd5be501527224befb5e92a2369"
JAVA_PKG_IUSE="doc source"
MYPN="legacy-${PN}5"

inherit java-pkg-2 java-pkg-simple

DESCRIPTION="Open-source graph component for Java"
HOMEPAGE="
	https://www.jgraph.com
	https://github.com/jgraph/legacy-jgraph5
	https://sourceforge.net/projects/jgraph/
"
SRC_URI="https://github.com/${PN}/${MYPN}/archive/${COMMIT}.tar.gz -> ${PF}.tar.gz"
S="${WORKDIR}/${MYPN}-${COMMIT}"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc examples source"

DEPEND=">=virtual/jdk-1.8:*"
RDEPEND=">=virtual/jre-1.8:*"

DOCS=( README README.md ChangeLog jgraph-5.13.0.0-jgraphmanual.pdf )

JAVA_SRC_DIR="src"

src_prepare() {
	default
	java-pkg_clean
}

src_install() {
	java-pkg-simple_src_install
	einstalldocs
}
