# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_10 )

inherit distutils-r1

DESCRIPTION="Python AgentX Implementation"
HOMEPAGE="https://github.com/hosthvo/pyagentx"
SRC_URI="https://github.com/hosthvo/pyagentx/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"

PATCHES="${FILESDIR}/updater.patch
		${FILESDIR}/python3.patch"

distutils_enable_tests setup.py
