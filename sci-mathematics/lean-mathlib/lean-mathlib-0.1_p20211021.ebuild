# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

COMMIT="3c11bd771ef17197a9e9fcd4a3fabfa2804d950c"

DESCRIPTION="Lean mathematical components library"
HOMEPAGE="https://github.com/leanprover-community/mathlib"
SRC_URI="https://github.com/leanprover-community/mathlib/archive/${COMMIT}.tar.gz -> ${PF}.tar.gz"
S="${WORKDIR}/mathlib-${COMMIT}"

KEYWORDS="~amd64"
LICENSE="Apache-2.0"
SLOT="0"
IUSE="test"

RDEPEND=">=dev-lang/lean-3.34.0"
DEPEND="
	${RDEPEND}
	sci-mathematics/mathlib-tools
"

RESTRICT="!test? ( test )"

src_configure() {
	leanpkg configure || die
}

src_compile() {
	leanpkg build || die
}

src_install() {
	dodoc -r docs
	rm -r docs || die
	insinto /usr/lib/lean/mathlib
	doins -r .
}

src_test() {
	leanpkg test || die
}
