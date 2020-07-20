# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PN0="PyInquirer"
P0="${PN0}-${PV}"

EGIT_REPO_URI="https://github.com/CITGuru/${PN0}"
case "${PV}" in
	9999)
		inherit git-r3
		;;
	*)
		SRC_URI="${EGIT_REPO_URI}/archive/${PV}.tar.gz -> ${P0}.tar.gz"
		KEYWORDS="~amd64"
		S="${WORKDIR}/${P0}"
esac

PYTHON_COMPAT=( python3_{6,7,8} )
inherit distutils-r1
distutils_enable_sphinx docs

DESCRIPTION="A Python module for common interactive command line UIs"
HOMEPAGE="${EGIT_REPO_URI}"
LICENSE="MIT"

SLOT="0"

RDEPEND="${PYTHON_DEPS}
	>=dev-python/prompt_toolkit-3.0.0[${PYTHON_USEDEP}]
	<dev-python/prompt_toolkit-3.1.0[${PYTHON_USEDEP}]
	>=dev-python/pygments-2.2.0[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"

src_prepare() {
	default
	sed -i -e 's/packages=find_packages(exclude=\[/\0"examples", /' setup.py ||
		die "Failed to patch setup.py"
}
