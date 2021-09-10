# Copyright 2019-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

COMMIT="a9df6936128ebe10374350c719a0fba74bc89803"
DOCS_BUILDER="doxygen"
DOCS_CONFIG_NAME="doxy-nanox"
DOCS_DIR="doc"

inherit autotools docs

DESCRIPTION="Runtime designed to serve as runtime support in parallel environments"
HOMEPAGE="
	https://pm.bsc.es/nanox
	https://github.com/bsc-pm/nanox
"
SRC_URI="https://github.com/bsc-pm/nanox/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE_NANOX="
	nanox-debug
	+nanox-instrumentation
	nanox-instrumentation-debug
	+nanox-performance
"
IUSE="${IUSE_NANOX} allocator ayudame dlb +extrae gasnet hwloc memkind memtracker mpi opencl papi sqlite resiliency task-callback +threads"

CDEPEND="
	ayudame? ( sys-cluster/temanejo[-ompss] )
	dlb? ( sys-cluster/dlb )
	extrae? ( sys-cluster/extrae[nanos] )
	gasnet? ( sys-cluster/gasnet )
	hwloc? ( sys-apps/hwloc )
	memkind? ( dev-libs/memkind )
	mpi? ( virtual/mpi )
	papi? ( dev-libs/papi )
	sqlite? ( dev-db/sqlite )
"
RDEPEND="
	${CDEPEND}
	opencl? ( virtual/opencl )
"
DEPEND="
	${CDEPEND}
	opencl? ( dev-util/opencl-headers )
"

PATCHES=( "${FILESDIR}/${PN}-no-Werror.patch" )
REQUIRED_USE="
	|| ( ${IUSE_NANOX//+/} )
	nanox-instrumentation? ( extrae )
	nanox-instrumentation-debug? ( extrae )
"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	use opencl && addwrite /dev/dri/
	use opencl && addwrite /var/lib/portage/home/.cache #mesa shader cache

	local myconf=(
		--disable-static
		--enable-gcc-new-atomic-builtins
		--enable-performance
		--enable-shared
		--without-cellsdk
		--without-chapel
		--without-cuda
		--without-mcc
		--without-nextsim
		--without-xdma

		$(use_enable allocator)
		$(use_enable memtracker)
		$(use_enable nanox-debug debug)
		$(use_enable nanox-instrumentation instrumentation)
		$(use_enable nanox-instrumentation-debug instrumentation-debug)
		$(use_enable nanox-performance performance)
		$(use_enable resiliency)
		$(use_enable task-callback)
		$(use_enable threads ult)

		$(use_with opencl)
	)

	if use ayudame; then
		myconf+=( "--with-ayudame=${EPREFIX}/usr" )
	else
		myconf+=( "--without-ayudame" )
	fi
	if use dlb; then
		myconf+=( "--with-dlb=${EPREFIX}/usr" )
	else
		myconf+=( "--without-dlb" )
	fi
	if use extrae; then
		myconf+=( "--with-extrae=${EPREFIX}/usr" )
	else
		myconf+=( "--without-extrae" )
	fi
	if use gasnet; then
		myconf+=( "--with-gasnet=${EPREFIX}/usr" )
	else
		myconf+=( "--without-gasnet" )
	fi
	if use hwloc; then
		myconf+=( "--with-hwloc=${EPREFIX}/usr" )
	else
		myconf+=( "--without-hwloc" )
	fi
	if use memkind; then
		myconf+=( "--with-memkind=${EPREFIX}/usr" )
	else
		myconf+=( "--without-memkind" )
	fi
	if use mpi; then
		myconf+=( "--with-mpi=${EPREFIX}/usr" )
	else
		myconf+=( "--without-mpi" )
	fi
	if use papi; then
		myconf+=( "--with-papi=${EPREFIX}/usr" )
	else
		myconf+=( "--without-papi" )
	fi
	if use sqlite; then
		myconf+=( "--with-sqlite3=${EPREFIX}/usr" )
	else
		myconf+=( "--without-sqlite3" )
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
	find "${ED}" -name '*.la' -delete || die
}
