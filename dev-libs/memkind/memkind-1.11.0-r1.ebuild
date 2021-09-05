# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} pypy3 )

inherit autotools linux-info python-any-r1 toolchain-funcs

DESCRIPTION="user extensible heap manager built on top of jemalloc"
HOMEPAGE="https://memkind.github.io/memkind"
SRC_URI="https://github.com/memkind/memkind/archive/v${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64"

LICENSE="BSD"
SLOT="0"
IUSE="+heap-manager openmp secure test +tls" #daxctl

RDEPEND="
	sys-block/ndctl
	sys-process/numactl
"
DEPEND="
	${RDEPEND}
	${PYTHON_DEPS}
"

PATCHES=( "${FILESDIR}/${PN}-respect-ar.patch" )
RESTRICT="test" # ERROR: ./test/test.sh requires a NUMA enabled system with more than one node.
#RESTRICT="!test? ( test )"

src_prepare() {
	default
	eautoreconf
	cd jemalloc && eautoreconf
}

src_configure() {
	tc-export AR
	local myconf=(
		--disable-silent-rules
		--enable-shared
		--enable-static
		--enable-daxctl
		$(use_enable heap-manager)
		$(use_enable openmp)
		$(use_enable secure)
		$(use_enable tls)
	)
	econf "${myconf[@]}"
}

src_test() {
	addwrite /proc/sys/vm/nr_hugepages
	echo 3000 > /proc/sys/vm/nr_hugepages
	emake check
}
