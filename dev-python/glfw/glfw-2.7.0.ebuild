# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1

DESCRIPTION="Python bindings for GLFW"
HOMEPAGE="https://github.com/FlorianRhiem/pyGLFW https://pypi.org/project/glfw"
SRC_URI="https://github.com/FlorianRhiem/pyGLFW/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/pyGLFW-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="media-libs/glfw"
