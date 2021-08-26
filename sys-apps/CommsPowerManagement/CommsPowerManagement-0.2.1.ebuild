# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MYPV="pwr-v${PV}"
PYTHON_COMPAT=( python3_{8..10} pypy3 )

inherit distutils-r1

DESCRIPTION="Python library providing various tools to work with Intel processors"
HOMEPAGE="https://github.com/intel/iCommsPowerManagement"
SRC_URI="https://github.com/intel/CommsPowerManagement/archive/refs/tags/${MYPV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${MYPV}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="${PYTHON_DEPS}"
DEPEND="${RDEPEND}"
IUSE="ansible"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

src_prepare() {
	distutils-r1_python_prepare_all
}

src_compile() {
	pushd "pwr" || die
	python_foreach_impl distutils-r1_python_compile
	popd || die
}

src_install() {
	python_foreach_impl python_install
	dodoc *.md
	#docinto telemetry
	#dodoc telemetry/*.md
	dodoc -r intel_sst_os_interface
	#where to put those?
	use ansible && dodoc -r ansible

}

python_install() {
	pushd "pwr" || die
	distutils-r1_python_install
	popd || die

	python_doscript power.py
	python_doscript sst_bf.py
	#python_doscript telemetry/pkgpower.py
}
