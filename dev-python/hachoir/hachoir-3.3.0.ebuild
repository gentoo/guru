# Copyright 2022-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1

DESCRIPTION="Hachoir is a Python library to view and edit a binary stream field by field "
HOMEPAGE="https://github.com/vstinner/hachoir/"
SRC_URI="https://github.com/vstinner/hachoir/archive/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

distutils_enable_tests pytest
