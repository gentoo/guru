# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=(python3_{9..12})

inherit distutils-r1

DESCRIPTION="elParaguayo's Qtile Extras"
HOMEPAGE="https://github.com/elParaguayo/qtile-extras"
SRC_URI="https://github.com/elParaguayo/qtile-extras/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="x11-wm/qtile"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-python/build
	dev-python/installer
	dev-python/setuptools-scm
"

export SETUPTOOLS_SCM_PRETEND_VERSION=${PV}
