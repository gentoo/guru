# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

COMMIT="d04fff95f686d5c372f7895551c40e7fa683ed6b"

DESCRIPTION="Lean mathematical components library"
HOMEPAGE="https://github.com/leanprover-community/mathlib"
SRC_URI="https://github.com/leanprover-community/mathlib/archive/${COMMIT}.tar.gz -> ${PF}.tar.gz"
S="${WORKDIR}/mathlib-${COMMIT}"

KEYWORDS="~amd64"
LICENSE="Apache-2.0"
SLOT="0"
IUSE="test"

RDEPEND=">=sci-mathematics/lean-3.41.0"
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
	dodoc -r docs/*
	rm -r docs || die
	insinto /usr/lib/lean/mathlib
	doins -r .
}

src_test() {
	leanpkg test || die
}
