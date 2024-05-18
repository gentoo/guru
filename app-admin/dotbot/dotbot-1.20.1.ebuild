# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1

DESCRIPTION="A tool that bootstraps your dotfiles"
HOMEPAGE="https://github.com/anishathalye/dotbot"
SRC_URI="https://github.com/anishathalye/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~ppc64 ~x86"

RDEPEND="
	dev-python/pyyaml[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest

python_test() {
	# test_shim fails when executed with superuser privileges:
	epytest -k "not test_shim"	#916987
}
