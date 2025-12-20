# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=standalone
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1

DESCRIPTION="A pure Python HTML5 parser that just works."
HOMEPAGE="https://github.com/EmilStenstrom/justhtml"
SRC_URI="https://github.com/EmilStenstrom/justhtml/archive/refs/tags/v${PV}.tar.gz -> justhtml-${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
