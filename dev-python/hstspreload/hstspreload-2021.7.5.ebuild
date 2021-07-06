# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7,8,9} )

inherit distutils-r1

DESCRIPTION="Chromium HSTS Preload list as a Python package"
HOMEPAGE="
	https://hstspreload.org
	https://github.com/sethmlarson/hstspreload
	https://pypi.org/project/hstspreload
"
SRC_URI="https://github.com/sethmlarson/hstspreload/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
KEYWORDS="~amd64 ~x86"
SLOT="0"

RESTRICT="mirror"
PROPERTIES="test_network"

distutils_enable_tests pytest
