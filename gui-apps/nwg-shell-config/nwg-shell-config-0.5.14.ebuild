# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{10..11} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1

SRC_URI="https://github.com/nwg-piotr/nwg-shell-config/archive/v${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64"

DESCRIPTION="nwg-shell configuration utility"
HOMEPAGE="https://github.com/nwg-piotr/nwg-shell-config"
LICENSE="MIT"

SLOT="0"

RDEPEND="
	gui-apps/nwg-shell
	sci-geosciences/geopy
	x11-libs/gtk+:3
"
DEPEND="${RDEPEND}"
