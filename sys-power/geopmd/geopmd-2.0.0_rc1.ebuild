# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MYPV="${PV/_rc/+rc}"
MYP="geopm-${MYPV}"
PYTHON_COMPAT=( python3_{10..11} )

inherit autotools python-single-r1

DESCRIPTION="Global Extensible Open Power Manager (Daemon)"
HOMEPAGE="https://github.com/geopm/geopm"
SRC_URI="https://github.com/geopm/geopm/archive/refs/tags/v${MYPV}.tar.gz -> ${MYP}.gh.tar.gz"
S="${WORKDIR}/geopm-${PV/_rc/-rc}/service"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="debug doc systemd"

RDEPEND="
	${PYTHON_DEPS}
	$(python_gen_cond_dep '
		>=dev-python/cffi-1.15.0[${PYTHON_USEDEP}]
		>=dev-python/dasbus-1.6[${PYTHON_USEDEP}]
		>=dev-python/jsonschema-3.2.0[${PYTHON_USEDEP}]
		>=dev-python/psutil-5.9.0[${PYTHON_USEDEP}]
	')
	dev-cpp/json11
	systemd? ( sys-apps/systemd:= )
"
DEPEND="
	${RDEPEND}
	dev-cpp/gtest
"
BDEPEND="
	doc? (
		dev-python/sphinx
		dev-python/sphinx-rtd-theme
		dev-python/sphinxemoji
	)
"

PATCHES=(
	"${FILESDIR}/${P}-system-gtest.patch"
	"${FILESDIR}/${P}-system-json11.patch"
	"${FILESDIR}/${P}-no-Werror.patch"
)
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

pkg_setup() {
	python-single-r1_pkg_setup
}

src_prepare() {
	rm -r contrib || die
	rm test/googletest.mk || die
	rm src/geopm/json11.hpp || die
	default
	echo "${PV}" > VERSION || die
	for ff in AUTHORS CODE_OF_CONDUCT.md CONTRIBUTING.rst COPYING COPYING-TPP; do
		if [[ ! -f ${ff} ]]; then
			cp ../${ff} . || die
		fi
	done
	eautoreconf
}

src_configure() {
	local myconf=(
		--disable-cnl-iogroup
		--disable-coverage
		--disable-dcgm
		--disable-levelzero
		--disable-nvml
		$(use_enable debug)
		$(use_enable doc docs)
		$(use_enable systemd)
	)
	econf "${myconf[@]}"
}

src_install() {
	default
	dodoc README.rst
	find "${ED}" -type f -name "*.la" -delete || die
}
