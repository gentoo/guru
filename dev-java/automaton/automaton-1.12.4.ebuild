# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-pkg-simple

MY_P="${PN}-${PV%.*}-${PV##*.}"

DESCRIPTION="Finite-state automata and regular expressions for Java"
HOMEPAGE="https://www.brics.dk/automaton/"
SRC_URI="https://www.brics.dk/automaton/${MY_P}.tar.gz"
S="${WORKDIR}/${MY_P%-*}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=">=virtual/jdk-1.8:*"
RDEPEND=">=virtual/jre-1.8:*"

JAVA_SRC_DIR="src"

src_compile() {
	java-pkg-simple_src_compile

	mkdir datatypes || die
	java -cp "${JAVA_JAR_FILENAME}" -Ddk.brics.automaton.datatypes=datatypes \
		dk.brics.automaton.Datatypes || die

	jar tf dist/automaton.jar > "${T}/upstream-entries" || die
	grep '\.aut$' "${T}/upstream-entries" > "${T}/expected-datatypes" || die

	local datatype
	while IFS= read -r datatype; do
		[[ -s datatypes/${datatype} ]] || die "Missing or empty datatype: ${datatype}"
	done < "${T}/expected-datatypes"

	java-pkg_addres "${JAVA_JAR_FILENAME}" datatypes
}
