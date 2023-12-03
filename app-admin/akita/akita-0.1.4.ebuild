# Copyright 2021-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} pypy3 )
PYTHON_REQ_USE="ncurses"
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1

DESCRIPTION="An HTTP log monitoring tool for your terminal"
HOMEPAGE="
	https://github.com/michael-lazar/Akita
	https://pypi.org/project/akita/
"
SRC_URI="https://github.com/michael-lazar/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/${PN^}-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

distutils_enable_tests pytest
