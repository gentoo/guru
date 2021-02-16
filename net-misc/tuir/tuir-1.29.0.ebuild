# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{3_7,3_8,3_9} )
PYTHON_REQ_USE="ncurses"
inherit distutils-r1

DESCRIPTION="A text-based interface (TUI) to view and interact with Reddit from your terminal"
HOMEPAGE="https://gitlab.com/ajak/tuir"
SRC_URI="https://gitlab.com/ajak/tuir/-/archive/v${PV}/tuir-v${PV}.tar.gz"

S="${WORKDIR}/${PN}-v${PV}"

LICENSE="MIT"

SLOT="0"

KEYWORDS="~amd64"

RDEPEND="${DEPEND}"

DEPEND="dev-python/beautifulsoup[${PYTHON_USEDEP}]
dev-python/decorator[${PYTHON_USEDEP}]
dev-python/requests[${PYTHON_USEDEP}]
dev-python/six[${PYTHON_USEDEP}]
dev-python/kitchen[${PYTHON_USEDEP}]"
