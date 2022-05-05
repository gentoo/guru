# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic fortran-2 toolchain-funcs

MY_PV="${PV/_p/+}"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="Subroutine Library in Systems and Control Theory"
HOMEPAGE="
	https://web.archive.org/web/20191022092917/http://www.slicot.org
	https://tracker.debian.org/pkg/slicot
"
SRC_URI="http://cdn-fastly.deb.debian.org/debian/pool/main/s/${PN}/${PN}_${MY_PV}.orig.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64"

IUSE="doc examples"

DEPEND="
	virtual/blas
	|| ( sci-libs/lapack[deprecated] sci-libs/openblas )
"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	default
	rm -f  "${S}/makefile" || die
	cp "${FILESDIR}/Makefile" "${S}" || die
}

src_prepare() {
	export SO="0"
	export VERS="${SO}.0"
	append-fflags "$($(tc-getPKG_CONFIG) --libs blas)" "$($(tc-getPKG_CONFIG) --libs lapack)"
	default
}

src_install() {
	dolib.so libslicot.so
	dolib.so "libslicot.so.${SO}"
	dolib.so "libslicot.so.${VERS}"
	use doc && HTML_DOCS=( libindex.html )
	use doc && HTML_DOCS+=( doc/*.html )
	einstalldocs
	if use examples; then
		insinto "/usr/share/${P}/examples"
		doins -r examples/.
		insinto "/usr/share/${P}/examples77"
		doins -r examples77/.
		insinto "/usr/share/${P}/benchmark_data"
		doins -r benchmark_data/.
	fi
}
