# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic

DESCRIPTION="An XQuery and XPath 2 library and command line utility written in C++"
HOMEPAGE="https://sourceforge.net/projects/xqilla/"
SRC_URI="https://downloads.sourceforge.net/${PN}/XQilla-${PV}.tar.gz"

S="${WORKDIR}/XQilla-${PV}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="static-libs tidy"

DEPEND="
	>=dev-libs/xerces-c-3.2.1
	net-libs/libnsl:=
	tidy? ( app-text/htmltidy:= )
"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}"/lib_to_lib64.patch )

src_prepare() {
	append-cxxflags -std=c++14
	default
	sed  -i 's/buffio.h/tidybuffio.h/g' src/functions/FunctionParseHTML.cpp || die
}
src_configure() {
	econf $(use_enable static-libs static) \
	--with-tidy=$(usex tidy /usr no) \
	--with-xerces=/usr
}

src_compile() {
	emake "LDFLAGS=${LDFLAGS} -lxerces-c -lnsl -lpthread $(usex tidy -ltidy '')"
}

src_install() {
	emake prefix="${EPREFIX}/usr" DESTDIR="${D}" install
	if ! use static-libs; then
		find "${ED}" -type f -iname '*.la' -delete || die
	fi
	einstalldocs
	dodoc LICENSE
}
