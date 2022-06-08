# Copyright 2019-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools flag-o-matic

DESCRIPTION="paraver kernel library"
HOMEPAGE="
	http://tools.bsc.es/paraver
	https://github.com/bsc-performance-tools/paraver-kernel
"
SRC_URI="https://github.com/bsc-performance-tools/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE="extended-objects extrae ompss openmp otf2"

RDEPEND="
	dev-libs/boost:=
	dev-libs/libxml2
	sys-libs/zlib
	sys-cluster/libbsctools:=
	extrae? ( sys-cluster/extrae )
	otf2? ( sys-cluster/otf2 )
"

DEPEND="${RDEPEND}"

DOCS=( README NEWS AUTHORS ChangeLog )
REQUIRED_USE="extrae? ( openmp )"
PATCHES=(
	"${FILESDIR}/${P}-unbundle-libbsctools.patch"
)

src_prepare() {
	rm -r utils/pcfparser || die
	default
	eautoreconf
}

src_configure() {
	append-ldflags '-lxml2'
	local myconf=(
		--disable-static
		--enable-shared
		--with-boost="${EPREFIX}/usr"
		--with-boost-libdir="${EPREFIX}/usr/$(get_libdir)"
		$(use_enable extended-objects)
		$(use_enable ompss)
		$(use_enable openmp)
	)

	if use extrae; then
		myconf+=( "--with-extrae=${EPREFIX}/usr" )
	else
		myconf+=( "--without-extrae" )
	fi
	if use otf2; then
		myconf+=( "--with-otf2=${EPREFIX}/usr" )
	else
		myconf+=( "--without-otf2" )
	fi

	econf "${myconf[@]}" || die
}

src_install() {
	default
	einstalldocs
	mkdir -p "${ED}/usr/share/${PN}" || die
	mv "${ED}/usr/share/filters-config" "${ED}/usr/share/${PN}/" || die
	mv "${ED}/usr/$(get_libdir)/paraver-kernel"/* "${ED}/usr/$(get_libdir)" || die
	find "${ED}" -name '*.la' -delete || die
}
