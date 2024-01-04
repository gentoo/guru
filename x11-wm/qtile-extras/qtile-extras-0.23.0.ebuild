# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=no
PYTHON_COMPAT=(python3_{9..12})

inherit distutils-r1 desktop

SRC_URI="https://github.com/elParaguayo/qtile-extras/archive/${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="amd64"

DESCRIPTION="Run Windows Applications on Linux as if they are native (Using a VM and FreeRDP)"
HOMEPAGE="https://github.com/casualsnek/cassowary"

BDEPEND="dev-python/setuptools
	dev-python/build
	dev-python/installer
	dev-python/setuptools-scm
	dev-python/wheel
"

RDEPEND="x11-wm/qtile"

DEPEND="${RDEPEND}"

LICENSE="MIT"
SLOT="0"
IUSE=""

export SETUPTOOLS_SCM_PRETEND_VERSION=7.0.0

python_compile() {
	${EPYTHON} -m build --wheel --no-isolation
}

python_install() {
	${EPYTHON} -m installer --destdir="${D}" dist/*.whl
}
