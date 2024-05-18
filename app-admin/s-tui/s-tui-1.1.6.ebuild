# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 optfeature

DESCRIPTION="Stress-Terminal UI monitoring tool"
HOMEPAGE="https://amanusk.github.io/s-tui/"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/amanusk/${PN}.git"
	EGIT_SUBMODULES=()
else
	SRC_URI="https://github.com/amanusk/${PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-2"
SLOT="0"

RDEPEND="
	>=dev-python/psutil-5.9.1[${PYTHON_USEDEP}]
	>=dev-python/urwid-2.0.1[${PYTHON_USEDEP}]
"

distutils_enable_tests unittest

pkg_postinst() {
	optfeature "Stress options in program menu" app-benchmarks/stress
}
