# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )

inherit python-r1

DESCRIPTION="Versatile replacement for vmstat, iostat and ifstat (clone of dstat)"
HOMEPAGE="https://github.com/scottchiefbaker/dool"

if [[ "${PV}" == "9999" ]]; then
	EGIT_REPO_URI="https://github.com/scottchiefbaker/dool.git"
	inherit git-r3
else
	SRC_URI="
		https://github.com/scottchiefbaker/dool/archive/refs/tags/v${PV}.tar.gz
			-> ${P}.tar.gz
	"
	KEYWORDS="~amd64 ~arm64 ~mips ~ppc ~ppc64 ~sparc ~x86 "
fi

LICENSE="GPL-2"
SLOT="0"
IUSE="doc examples"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="${PYTHON_DEPS}"
DEPEND="${RDEPEND}"

src_compile() {
	:
}

python_install() {
	python_doscript "${PN}"
	python_domodule plugins/${PN}_*.py
}

src_install() {
	python_foreach_impl python_install

	doman "docs/${PN}.1"

	einstalldocs

	if use examples; then
		dodoc examples/{mstat,read}.py
	fi

	if use doc; then
		dodoc docs/*.html
	fi
}

src_test() {
	python_foreach_impl emake test
}
