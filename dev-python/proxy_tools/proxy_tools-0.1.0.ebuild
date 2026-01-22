# Copyright 2020-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517="setuptools"
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 pypi

DESCRIPTION="Simple proxy (as in the GoF design pattern)"
HOMEPAGE="https://pypi.org/project/proxy_tools/ https://github.com/jtushman/proxy_tools"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
