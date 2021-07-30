# Copyright 2019-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

COMMIT="71fc5d04c9f8fc9818a05cdc608e2d13af825d83"
DOCS_BUILDER="doxygen"
DOCS_CONFIG_NAME="doxygen.conf"
DOCS_DIR="doc"

inherit autotools docs

DESCRIPTION="low-level network API for high-performance networking on high-performance computing systems"
HOMEPAGE="
	https://www.cs.sandia.gov/Portals/portals4.html
	https://github.com/Portals4/portals4
"
SRC_URI="https://github.com/Portals4/portals4/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="knem me-triggered pmi reliable-udp test transport-ib transport-shmem +transport-udp unordered-matching zero-mrs" #ppe

RDEPEND="
	dev-libs/libev
	dev-libs/libxml2

	knem? ( sys-cluster/knem )
	pmi? ( sys-cluster/pmix[pmi] )
	transport-ib? ( sys-fabric/ofed )
"
#	ppe? ( sys-cluster/xpmem )
DEPEND="${RDEPEND}"

RESTRICT="!test? ( test )"
REQUIRED_USE="
	^^ ( transport-ib transport-udp )

	knem? ( transport-shmem )
	reliable-udp? ( transport-udp )
"
#	^^ ( ppe transport-shmem )

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		--disable-fast
		--disable-kitten
		--disable-picky
		--disable-pmi-from-portals
		--disable-static
		--with-ev="${EPREFIX}/usr"

		$(use_enable me-triggered)
		$(use_enable reliable-udp)
		$(use_enable test testing)
		$(use_enable transport-ib)
		$(use_enable transport-shmem)
		$(use_enable transport-udp)
		$(use_enable unordered-matching)
		$(use_enable zero-mrs)
	)
#		$(use_enable ppe)

	if use knem; then
		myconf+=( "--with-knem=${EPREFIX}/usr" )
	else
		myconf+=( "--without-knem" )
	fi
#	if use ppe; then
#		myconf+=( "--with-xpmem=${EPREFIX}/usr" )
#	else
#		myconf+=( "--without-xpmem" )
#	fi
	if use pmi; then
		myconf+=( "--with-pmi=${EPREFIX}/usr" )
	else
		myconf+=( "--without-pmi" )
	fi
	if use transport-ib; then
		myconf+=( "--with-ofed=${EPREFIX}/usr" )
	else
		myconf+=( "--without-ofed" )
	fi

	econf "${myconf[@]}"
}

src_compile() {
	default
	docs_compile
}

src_install() {
	default
	einstalldocs
	find "${D}" -name '*.la' -delete || die
}
