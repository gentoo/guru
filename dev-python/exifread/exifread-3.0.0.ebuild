# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_SETUPTOOLS=bdepend
MY_PN="exif-py"
PYTHON_COMPAT=( python3_{10..11} pypy3 )

inherit distutils-r1

DESCRIPTION="Easy to use Python module to extract Exif metadata from tiff and jpeg files"
HOMEPAGE="
	https://pypi.org/project/ExifRead/
	https://github.com/ianare/exif-py
"
SRC_URI="https://github.com/ianare/${MY_PN}/archive/${PV}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
