# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..10} )
inherit python-r1

QA_PREBUILT="usr/lib/*"
DESCRIPTION="Fast, correct Python JSON library supporting dataclasses, datetimes, and numpy"
HOMEPAGE="https://github.com/ijl/orjson"

# As per PEP 600 manylinux platform tag specfication, a wheel tagged
# manylinux_x_y should work with systems with >=glibc-x.y , and on Python
# versions 3.8 to 3.10
SRC_URI="
	amd64? (
		https://files.pythonhosted.org/packages/cp310/${P:0:1}/${PN%%-bin}/${P//-bin}-cp310-cp310-manylinux_2_24_x86_64.whl
		-> ${P}-amd64.zip
	)
	arm64? (
		https://files.pythonhosted.org/packages/cp310/${P:0:1}/${PN%%-bin}/${P//-bin}-cp310-cp310-manylinux_2_24_aarch64.whl
		-> ${P}-arm64.zip
	)
	"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

RESTRICT="!test? ( test )"
IUSE="test"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

BDEPEND="app-arch/unzip"
RDEPEND="${PYTHON_DEPS}"

pkg_setup() {
	python_setup
}

S="${WORKDIR}"

src_install() {
	if use amd64; then
		ARCH="x86_64"
	elif use arm64; then
		ARCH="aarch64"
	fi
	do_install() {
		local my_installdir="$(python_get_sitedir)"
		my_installdir="${my_installdir##${EPREFIX}/}"
		insinto "${my_installdir}"
		# Even though the soname is compatible, the python version has to be
		# corrected in order for it to work
		newins orjson/${PN//-bin}.cpython-310-${ARCH}-linux-gnu.so ${PN//-bin}.cpython-3${EPYTHON##python3.}-${ARCH}-linux-gnu.so
		python_domodule ${P//-bin}.dist-info
	}
	python_foreach_impl do_install
}
