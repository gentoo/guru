# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..9} )
DISTUTILS_USE_SETUPTOOLS=rdepend

inherit distutils-r1 optfeature

DESCRIPTION="Stress-Terminal UI monitoring tool"
HOMEPAGE="https://amanusk.github.io/s-tui/"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/amanusk/${PN}.git"
	EGIT_SUBMODULES=()
else
	# Pypi source doesn't include tests
	SRC_URI="https://github.com/amanusk/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-2"
SLOT="0"

RDEPEND="
	>=dev-python/psutil-5.6.0[${PYTHON_USEDEP}]
	>=dev-python/urwid-2.0.1[${PYTHON_USEDEP}]
"

distutils_enable_tests unittest

pkg_postinst() {
	elog "To get additional features, some optional runtime dependencies"
	elog "may be installed:"
	elog ""
	optfeature "Stress options in program menu" app-benchmarks/stress
}
