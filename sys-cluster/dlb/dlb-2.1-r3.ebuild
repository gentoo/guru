# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_10 )
PYTHON_REQ_USE="tk"

inherit autotools python-single-r1

DESCRIPTION="Dynamically react to application imbalance by modifying the number of resources"
HOMEPAGE="https://github.com/bsc-pm/dlb"
SRC_URI="https://github.com/bsc-pm/dlb/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="hwloc instrumentation mpi openmp test"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"
RESTRICT="!test? ( test )"

DEPEND="
	hwloc? ( sys-apps/hwloc )
	mpi? ( virtual/mpi )
"
RDEPEND="
	${PYTHON_DEPS}
	${DEPEND}
	dev-lang/tk
	$(python_gen_cond_dep 'dev-python/matplotlib[tk,${PYTHON_USEDEP}]')
"
BDEPEND="test? ( sys-devel/bc )"

PATCHES=(
	"${FILESDIR}/${P}-pygen-python3.patch"
	"${FILESDIR}/${P}-tkinter.patch"
	"${FILESDIR}/${P}-chmod.patch"
)

src_prepare() {
	default
	sed -e "s|lib/|$(get_libdir)/|" -i scripts/viewer/dlb_wrapper.py || die

	eautoreconf
}

src_configure() {
	local myconf=(
		--enable-shared
		--with-pic
		$(use_enable instrumentation)
		$(use_enable openmp)
		$(use_enable test static)
		$(use_with hwloc)
		$(use_with mpi)
	)
	econf "${myconf[@]}"
}

src_install() {
	DESTDIR="${ED}" default
	find "${D}" -name '*.la' -delete || die
	find "${D}" -name '*.a' -delete || die
}
