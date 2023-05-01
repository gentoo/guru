# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} ) #pypy3 has warnings

inherit distutils-r1 perl-module

DESCRIPTION="User space software for Intel(R) Resource Director Technology"
HOMEPAGE="
	https://www.intel.com/content/www/us/en/architecture-and-technology/resource-director-technology.html
	https://github.com/intel/intel-cmt-cat
"
SRC_URI="https://github.com/intel/intel-cmt-cat/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
IUSE="perl"

RDEPEND="perl? ( dev-lang/perl:= )"

PATCHES=(
	"${FILESDIR}/${P}-perl-makefile.patch"
	"${FILESDIR}/${P}-no-strip.patch"
	"${FILESDIR}/${PN}-4.3.0-respect-flags.patch"
)

distutils_enable_tests unittest

src_prepare() {
	mkdir -p "${T}/prefix" || die

	distutils-r1_python_prepare_all
}

src_compile() {
	emake all PREFIX="${T}/prefix"

	pushd "lib/python" || die
	python_foreach_impl distutils-r1_python_compile
	popd || die

	if use perl; then
		pushd "lib/perl" || die
		perl-module_src_configure
		perl-module_src_compile
		popd || die
	fi
}

src_install() {
	emake install PREFIX="${T}/prefix"

	dobin "${T}"/prefix/bin/*
	doheader "${T}"/prefix/include/*
	doman "${T}"/prefix/man/man*/*
	dolib.so "${T}"/prefix/lib/*

	dobin tools/membw/membw
	dobin snmp/rdt-agentx.pl

	dodoc ChangeLog README.md
	docinto membw
	dodoc tools/membw/README
	docinto pqos
	dodoc -r pqos/README pqos/configs
	docinto lib
	dodoc lib/README
	docinto lib/python
	dodoc lib/python/README.md
	docinto snmp
	dodoc snmp/README
	docinto rdtset
	dodoc rdtset/README

	unset DOCS
	python_foreach_impl python_install

	if use perl; then
		pushd "lib/perl" || die
		unset DOCS
		myinst=( DESTDIR="${D}" )
		perl-module_src_install
		popd || die
		docinto lib/perl
		dodoc lib/perl/README
	fi
}

src_test() {
	LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:${S}/lib" python_foreach_impl python_test
}

python_install() {
	pushd "lib/python" || die
	distutils-r1_python_install
	popd || die
}

python_test() {
	pushd "lib/python" || die
	eunittest
	popd || die
}
