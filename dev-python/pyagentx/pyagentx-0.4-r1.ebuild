# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1

DESCRIPTION="Python AgentX Implementation"
HOMEPAGE="https://github.com/hosthvo/pyagentx"
SRC_URI="https://github.com/hosthvo/pyagentx/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"

PATCHES="${FILESDIR}/updater.patch
		${FILESDIR}/python3.patch"
