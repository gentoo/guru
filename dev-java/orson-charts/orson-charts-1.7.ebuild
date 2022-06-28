# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

JAVA_SRC_DIR=(
	"src/main/java/com/orsoncharts"
	"src/main/java/com/orsoncharts/axis"
	"src/main/java/com/orsoncharts/data"
	"src/main/java/com/orsoncharts/data/category"
	"src/main/java/com/orsoncharts/data/function"
	"src/main/java/com/orsoncharts/data/xyz"
	"src/main/java/com/orsoncharts/graphics3d"
	"src/main/java/com/orsoncharts/interaction"
	"src/main/java/com/orsoncharts/label"
	"src/main/java/com/orsoncharts/legend"
	"src/main/java/com/orsoncharts/marker"
	"src/main/java/com/orsoncharts/plot"
	"src/main/java/com/orsoncharts/renderer"
	"src/main/java/com/orsoncharts/renderer/category"
	"src/main/java/com/orsoncharts/renderer/category/doc-files"
	"src/main/java/com/orsoncharts/renderer/xyz"
	"src/main/java/com/orsoncharts/style"
	"src/main/java/com/orsoncharts/table"
	"src/main/java/com/orsoncharts/util"
	"src/main/java/com/orsoncharts/util/json"
	"src/main/java/com/orsoncharts/util/json/parser"
)

inherit java-pkg-2 java-pkg-simple

DESCRIPTION="A fast, lightweight charts generator for the Java platform"
HOMEPAGE="https://github.com/jfree/orson-charts"
SRC_URI="https://github.com/jfree/orson-charts/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${P}"

LICENSE="GPL-3+"
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
	java-pkg_newjar orson-charts.jar orsoncharts.jar
	dodoc README.md
}
