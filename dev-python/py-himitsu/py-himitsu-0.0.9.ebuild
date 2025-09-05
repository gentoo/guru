# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..14} )
DISTUTILS_USE_PEP517=hatchling
PYPI_NONORMALIZE=1

inherit distutils-r1 pypi

DESCRIPTION="A python client library for himitsu"
HOMEPAGE="https://pypi.org/project/py-himitsu/ https://git.sr.ht/~apreiml/py-himitsu"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~riscv"

RDEPEND="
	>=app-admin/himitsu-0.9:=
"

DEPEND="${RDEPEND}"
