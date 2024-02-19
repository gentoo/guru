# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/spyoungtech/pyclip.git"
else
	SRC_URI="https://github.com/spyoungtech/pyclip/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"
	KEYWORDS="~amd64 ~arm ~arm64 ~x86"
fi

DESCRIPTION="Python clipboard module"
HOMEPAGE="https://pypi.org/project/pyclip/"
LICENSE="Apache-2.0"
SLOT="0"
IUSE="wayland X"
RESTRICT="test"
DOCS="${S}/docs/README.md"
REQUIRED_USE="|| ( wayland X )"

RDEPEND="
	wayland? ( gui-apps/wl-clipboard )
	X? ( x11-misc/xclip )
"
