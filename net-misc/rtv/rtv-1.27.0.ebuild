# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{3_7,3_8,3_9} )
PYTHON_REQ_USE="ncurses"
inherit distutils-r1

DESCRIPTION="Browse Reddit from your terminal"
HOMEPAGE="https://github.com/michael-lazar/rtv"
SRC_URI="https://github.com/michael-lazar/rtv/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="dev-python/beautifulsoup[${PYTHON_USEDEP}]
dev-python/decorator[${PYTHON_USEDEP}]
dev-python/requests[${PYTHON_USEDEP}]
dev-python/six[${PYTHON_USEDEP}]
dev-python/kitchen[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"
