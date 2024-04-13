# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=flit
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1

MY_PV="v${PV}"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="An async python inotify package"
HOMEPAGE="https://gitlab.com/Taywee/asyncinotify"
SRC_URI="https://gitlab.com/Taywee/${PN}/-/archive/${MY_PV}/${MY_P}.tar.bz2 -> ${P}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

S="${WORKDIR}/${MY_P}"

distutils_enable_sphinx docs "dev-python/tomli"

distutils_enable_tests unittest
