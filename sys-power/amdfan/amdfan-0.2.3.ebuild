# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
# shellcheck disable=2034

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{11..12} )

inherit distutils-r1 systemd autotools

DESCRIPTION="Updated AMD Fan control utility forked from amdgpu-fan and updated."
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
	distutils-r1_src_prepare

	# this sed isn't clean. i haven't used PATCHES for this, since we're
	# hoping to find a better fix upstream. suggestions are welcome
	#
	# relevant discussion:
	# https://github.com/mcgillij/amdfan/commit/529fd3d4#r144705633
	sed -i '/^include = \["dist\/systemd\/amdfan.service"\]$/d' pyproject.toml || die

	eautoreconf -vfi
}

src_configure() {
	# i don't like hardcoding --bindir like this, but
	# if i don't, i get ${exec_prefix}/bin instead of /usr/bin
	#
	# is there a better approach?
	econf --bindir="${EPREFIX}"/usr/bin
}

src_install() {
	newinitd dist/openrc/amdfan amdfan
	systemd_dounit dist/systemd/amdfan.service

	distutils-r1_src_install
}

python_test() {
	"${EPYTHON}" -m unittest discover tests || die
}
