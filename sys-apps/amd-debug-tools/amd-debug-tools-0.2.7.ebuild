# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..13} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1

DESCRIPTION="Helpful tools for debugging AMD Zen systems"
HOMEPAGE="https://git.kernel.org/pub/scm/linux/kernel/git/superm1/amd-debug-tools.git"
SRC_URI="https://git.kernel.org/pub/scm/linux/kernel/git/superm1/${PN}.git/snapshot/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-python/jinja2[${PYTHON_USEDEP}]
	dev-python/matplotlib[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
	dev-python/pandas[${PYTHON_USEDEP}]
	dev-python/pyudev[${PYTHON_USEDEP}]
	dev-python/seaborn[${PYTHON_USEDEP}]
	dev-python/tabulate[${PYTHON_USEDEP}]"

RDEPEND="${DEPEND}
	|| ( >=media-libs/libv4l-1.30.1[utils] sys-apps/edid-decode )
	sys-power/iasl"

distutils_enable_tests unittest

python_test() {
	eunittest -s src
}
