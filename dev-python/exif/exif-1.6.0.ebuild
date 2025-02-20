# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
EAPI=8

PYTHON_COMPAT=( python3_{11..13} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1

DESCRIPTION="Read and modify image EXIF metadata using Python."
HOMEPAGE="https://gitlab.com/TNThieding/exif"
SRC_URI="https://gitlab.com/TNThieding/${PN}/-/archive/v${PV}/${PN}-v${PV}.tar.bz2"

S="${WORKDIR}/${PN}-v${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/plum-0.5.0[${PYTHON_USEDEP}]
	<dev-python/plum-2.0.0[${PYTHON_USEDEP}]
"
