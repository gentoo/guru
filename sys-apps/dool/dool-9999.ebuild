# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..9} )

inherit python-r1

DESCRIPTION="Versatile replacement for vmstat, iostat and ifstat (clone of dstat)"
HOMEPAGE="https://github.com/scottchiefbaker/dool"

if [[ "${PV}" == "9999" ]]; then
	EGIT_REPO_URI="https://github.com/scottchiefbaker/dool.git"
	inherit git-r3
else
	DOOL_COMMIT_ID="6b89f2d0b6e38e1c8d706e88a12e020367f5100d"
	SRC_URI="https://github.com/scottchiefbaker/dool/archive/${DOOL_COMMIT_ID}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${PN}-${DOOL_COMMIT_ID}"
fi

if [[ "${PV}" != "9999" ]]; then
	KEYWORDS="~alpha ~amd64 ~arm64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-linux"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE="doc examples"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="${PYTHON_DEPS}"
DEPEND="${RDEPEND}"

PATCHES=(
	"${FILESDIR}/0001-Key-for-key-in-dool_disk_avgqu.py-to-avoid-KeyError.patch"
)

src_compile() {
	:
}

src_install() {
	python_foreach_impl python_doscript "${PN}"

	insinto "/usr/share/${PN}"
	newins "${PN}" "${PN}.py"
	doins plugins/${PN}_*.py

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
