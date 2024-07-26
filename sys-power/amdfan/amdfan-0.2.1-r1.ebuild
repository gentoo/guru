# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 systemd autotools

DESCRIPTION="Updated AMD Fan control utility forked from amdgpu-fan and updated. "
HOMEPAGE="https://mcgillij.dev/pages/amdfan.html"
SRC_URI="https://github.com/mcgillij/amdfan/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	${PYTHON_DEPS}
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/rich[${PYTHON_USEDEP}]
"
DEPEND="${PYTHON_DEPS}"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"
DOCS=( README.md )

distutils_enable_tests unittest

src_prepare() {
	default

	sed -i '/^include = \["dist\/systemd\/amdfan.service"\]$/d' pyproject.toml || die

	eautoreconf
}

src_configure() {
	econf
}

python_install_all() {
	distutils-r1_python_install_all
}

src_install() {
	default

	newinitd dist/openrc/amdfan amdfan
	systemd_dounit dist/systemd/amdfan.service
}

python_test() {
	"${EPYTHON}" -m unittest discover tests || die
}
