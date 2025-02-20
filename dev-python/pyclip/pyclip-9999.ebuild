# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..12} )

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
IUSE="wayland +X"
REQUIRED_USE="|| ( wayland X )"

# Needs a working xorg/wayland setup
RESTRICT="test"

RDEPEND="
	wayland? ( gui-apps/wl-clipboard )
	X? ( x11-misc/xclip )
"

DOCS=( docs/README.md )

src_prepare() {
	# Clipboard detection should respect USE flags
	if use wayland && ! use X; then
		sed -ie "/linux':/s/elif .*/elif False:/" pyclip/util.py || die
	elif ! use wayland && use X; then
		sed -ie "/WAYLAND/s/elif .*/elif False:/" pyclip/util.py || die
	fi
	distutils-r1_src_prepare
}

pkg_postinst() {
	if use wayland && use X; then
		elog "If you wish to use the xclip backend over the wl-clipboard backend,"
		elog "unset the WAYLAND_DISPLAY environment variable or consider"
		elog "installing ${CATEGORY}/${PN}[-wayland,X] instead."
	fi
}
