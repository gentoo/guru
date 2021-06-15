# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..9} )
PYTHON_REQ_USE="tk"

inherit autotools python-single-r1

DESCRIPTION="Dynamically react to application imbalance by modifying the number of resources"
HOMEPAGE="https://github.com/bsc-pm/dlb"
SRC_URI="https://github.com/bsc-pm/dlb/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64"

IUSE="hwloc instrumentation mpi openmp"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

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

PATCHES=( "${FILESDIR}/${P}-pygen-python3.patch" )

src_prepare() {
	default
	sed -e "s|chmod +x \$(|chmod +x ${ED}/\$(|g" -i Makefile.am || die

	# Python3 fixes
	sed -e "s/Tkinter/tkinter/" \
		-e "s/import ttk/from tkinter import ttk/" \
		-e "s/import tkMessageBox/from tkinter import messagebox/" \
		-e "s/tkMessageBox/messagebox/g" \
		-i scripts/viewer/dlb_cpu_usage.in || die

	sed -e "s/Tkinter/tkinter/" \
		-e "s/import ttk/from tkinter import ttk/" \
		-e "s/, NavigationToolbar2TkAgg//" \
		-e "/FigureCanvasTkAgg$/a from matplotlib.backends.backend_qt5agg import NavigationToolbar2QT" \
		-e "s/NavigationToolbar2TkAgg/NavigationToolbar2QT/g" \
		-i scripts/viewer/dlb_viewer.py.in || die

	sed -e "s|lib/|$(get_libdir)/|" -i scripts/viewer/dlb_wrapper.py || die
	sed -e "s|Tkinter|tkinter|" -i scripts/viewer/progressmeter.py || die

	eautoreconf
}

src_configure() {
	local myconf=(
		--disable-static
		--enable-shared
		--with-pic
		$(use_enable instrumentation)
		$(use_enable openmp)
		$(use_with hwloc)
		$(use_with mpi)
	)
	econf "${myconf[@]}"
}

src_install() {
	default
	find "${D}" -name '*.la' -delete || die
}
