# Copyright 2025
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_11 python3_12 )

inherit distutils-r1

DESCRIPTION="Convert pyproject.toml to Gentoo ebuilds automatically."
HOMEPAGE=""
SRC_URI="https://pypi.io/packages/source/p/pyproject2ebuild/pyproject2ebuild-0.0.1.tar.gz"

LICENSE="GPL-3.0-or-later"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	
"
RDEPEND="${DEPEND}"

