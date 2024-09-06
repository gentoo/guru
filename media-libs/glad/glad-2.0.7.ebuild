# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..13} )
DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Multi-Language Vulkan/GL/GLES/EGL/GLX/WGL Loader-Generator"
HOMEPAGE="https://github.com/Dav1dde/glad"
SRC_URI="https://github.com/Dav1dde/glad/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="dev-python/jinja"
RDEPEND="${DEPEND}"

src_prepare(){
	distutils-r1_src_prepare

	sed -i 's@level=logging.DEBUG@level=logging.WARN@g' "glad/__main__.py" || die
	sed -i 's@find_packages@find_namespace_packages@g' "setup.py" || die
}
