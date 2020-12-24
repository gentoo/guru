# Copyright 2019-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
#PYTHON_COMPAT=( pypy3 python3_{7,8,9} )
inherit autotools #distutils-r1

DESCRIPTION="tool that will dynamically react to the application imbalance modifying the number of resources"
HOMEPAGE="https://github.com/bsc-pm/dlb"
SRC_URI="https://github.com/bsc-pm/dlb/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64"
#TODO: correctly install python stuff
IUSE="hwloc instrumentation mpi openmp" # python"

DEPEND="
	hwloc? ( sys-apps/hwloc )
	mpi? ( virtual/mpi )
"
#instrumentation ( sys-cluster/extrae )
RDEPEND="${DEPEND}"
#REQUIRED_USE="
#	python? ( ${PYTHON_REQUIRED_USE} )
#"

src_prepare() {
	sed -e "s|chmod +x \$(|chmod +x ${ED}/\$(|g" -i Makefile.am || die
	default
	eautoreconf
#	if use python; then
#		distutils-r1_python_prepare_all
#	fi
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
#	if use python; then
#		python_foreach_impl distutils-r1_python_install
#	fi
}

src_compile() {
	default
#	if use python; then
#		python_foreach_impl distutils-r1_python_compile
#	fi
}

src_install() {
	default
#	rm -rf "${D}/usr/lib/python*" || die
#	if use python; then
#		python_foreach_impl distutils-r1_python_install
#	fi
	find "${D}" -name '*.la' -delete || die
}
