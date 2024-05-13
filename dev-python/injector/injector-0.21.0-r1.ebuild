# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..12} )

inherit distutils-r1

DESCRIPTION="Python dependency injection framework, inspired by Guice"
HOMEPAGE="https://github.com/python-injector/injector"
SRC_URI="
	https://github.com/python-injector/${PN}/archive/refs/tags/${PV}.tar.gz
		-> ${P}.gh.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-linux"

distutils_enable_sphinx docs
distutils_enable_tests pytest

python_install_all() {
	distutils-r1_python_install_all
}
