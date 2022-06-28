# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

JAVA_SRC_DIR=(
	"src/main/java/com/orsonpdf"
	"src/main/java/com/orsonpdf/filter"
	"src/main/java/com/orsonpdf/shading"
	"src/main/java/com/orsonpdf/util"
)

inherit java-pkg-2 java-pkg-simple

DESCRIPTION="A fast, lightweight PDF generator for the Java platform"
HOMEPAGE="https://github.com/jfree/orsonpdf"
SRC_URI="https://github.com/jfree/orsonpdf/archive/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${P}"

LICENSE="GPL-3+ BSD"
SLOT="1"
KEYWORDS="~amd64"

RDEPEND=">=virtual/jre-1.8:*"
DEPEND=">=virtual/jdk-1.8:*"

RESTRICT="test"

src_prepare() {
	java-pkg_clean
	default
}

src_install() {
	java-pkg_dojar orsonpdf.jar
	dodoc README.md
}
