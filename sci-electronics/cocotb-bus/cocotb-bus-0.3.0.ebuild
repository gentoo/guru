# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

DESCRIPTION="Reusable testbenching tools and bus interfaces for cocotb"
HOMEPAGE="https://github.com/cocotb/cocotb-bus"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

# Tests require nox and EDA tools, can't work inside network sandbox
RESTRICT=test

RDEPEND="
	>=sci-electronics/cocotb-1.6.0[${PYTHON_USEDEP}]
	net-analyzer/scapy
"

DEPEND="${RDEPEND}"
