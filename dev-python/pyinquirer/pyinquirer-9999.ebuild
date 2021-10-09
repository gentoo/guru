# Copyright 1999-2021 Gentoo Authors
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

PYTHON_COMPAT=( python3_8 )
inherit distutils-r1
distutils_enable_sphinx docs
distutils_enable_tests pytest

DESCRIPTION="A Python module for common interactive command line UIs"
HOMEPAGE="https://github.com/CITGuru/PyInquirer"
LICENSE="MIT"

SLOT="0"

# Tests are outdated, they fail for >dev-python/ptyprocess-0.5.1
RESTRICT="test"

RDEPEND="
	>=dev-python/prompt_toolkit-3.0.0[${PYTHON_USEDEP}]
	<dev-python/prompt_toolkit-3.1.0[${PYTHON_USEDEP}]
	>=dev-python/pygments-2.2.0[${PYTHON_USEDEP}]"
DEPEND="
	${RDEPEND}
	test? (
		dev-python/testfixtures[${PYTHON_USEDEP}]
		>=dev-python/pytest-html-1.10.1[${PYTHON_USEDEP}]
		>=dev-python/pytest-xdist-1.15.0[${PYTHON_USEDEP}]
		>=dev-python/ptyprocess-0.5.1[${PYTHON_USEDEP}]
		>=dev-python/regex-2016.11.21[${PYTHON_USEDEP}] )"

src_prepare() {
	default
	sed -i -e 's/packages=find_packages(exclude=\[/\0"examples", /' setup.py ||
		die "Failed to patch setup.py"
}
