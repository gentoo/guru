# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} pypy3 )

inherit autotools linux-info python-any-r1 toolchain-funcs

DESCRIPTION="user extensible heap manager built on top of jemalloc"
HOMEPAGE="https://memkind.github.io/memkind/"
SRC_URI="https://github.com/memkind/memkind/archive/v${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64"

LICENSE="BSD"
SLOT="0"
IUSE="+daxctl debug decorators filelog +heap-manager hwloc initial-exec-tls openmp secure test +tls"

RDEPEND="
	daxctl? ( sys-block/ndctl )
	hwloc? ( sys-apps/hwloc )
	sys-process/numactl
"
DEPEND="
	${RDEPEND}
	${PYTHON_DEPS}
"

PATCHES=( "${FILESDIR}/${PN}-respect-ar.patch" )
RESTRICT="test" # ERROR: ./test/test.sh requires a NUMA enabled system with more than one node.
#RESTRICT="!test? ( test )"

pkg_pretend() {
	linux-info_pkg_setup
	CONFIG_CHECK_MODULES=""
	if use daxctl; then
		CONFIG_CHECK_MODULES+="DEV_DAX_KMEM "
	fi
	if linux_config_exists; then
		for module in ${CONFIG_CHECK_MODULES}; do
			linux_chkconfig_present ${module} || ewarn "${module} needs to be enabled"
		done
	fi
}

src_prepare() {
	default
	eautoreconf
	pushd jemalloc || die
	eautoreconf
	popd || die
}

src_configure() {
	tc-export AR
	local myconf=(
		--disable-debug
		--disable-gcov
		--enable-shared
		--enable-static
		$(use_enable daxctl)
		$(use_enable decorators)
		$(use_enable debug debug-jemalloc)
		$(use_enable heap-manager)
		$(use_enable hwloc)
		$(use_enable initial-exec-tls memkind-initial-exec-tls)
		$(use_enable filelog logging-to-file)
		$(use_enable openmp)
		$(use_enable secure)
		$(use_enable tls)
	)
	econf "${myconf[@]}"
}

src_install() {
	default
	find "${ED}" -name '*.la' -delete || die
	find "${ED}" -name '*.a' -delete || die
}

src_test() {
	addwrite /proc/sys/vm/nr_hugepages
	NR_HUGEPAGES_INITIAL="$(cat /proc/sys/vm/nr_hugepages)" || die
	echo 3000 > /proc/sys/vm/nr_hugepages || die
	emake check
	echo ${NR_HUGEPAGES_INITIAL} > /proc/sys/vm/nr_hugepages || die
}
