# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7,8} )
DISTUTILS_USE_SETUPTOOLS=rdepend
inherit distutils-r1 vcs-snapshot

DESCRIPTION="NiceHash cryptocurrency mining client for Linux"
HOMEPAGE="https://github.com/YoRyan/nuxhash"

SRC_URI="https://github.com/YoRyan/nuxhash/archive/33e9a095a41a6828959927f867efe4d2df398ede.tar.gz -> ${P}.tar.gz"
# Nuxhash itself is GPL, but it downloads the excavator proprietary blob on startup
LICENSE="GPL-3 excavator-EULA"
SLOT="0"
IUSE="gui"
KEYWORDS="~amd64"
RESTRICT="test"

RDEPEND="
	dev-libs/libbsd
	dev-python/requests[${PYTHON_USEDEP}]
	net-misc/curl
	virtual/opencl
	>=x11-drivers/nvidia-drivers-387
	x11-libs/libxcb
	x11-libs/libXau
	x11-libs/libXdmcp
	x11-libs/libXext
	x11-libs/libX11
	gui? ( dev-python/wxpython:4.0[${PYTHON_USEDEP}] )
"

PATCHES=(
	"${FILESDIR}/nuxhash-1.0.0_beta2_p20191013-fixurl.patch"
)

python_prepare_all() {
	use gui || eapply "${FILESDIR}/nuxhash-1.0.0_beta2_p20191013-remove-gui.patch"
	distutils-r1_python_prepare_all
}

python_test() {
	for t in tests/test_*.py; do
		"${EPYTHON}" "${t}" || die
	done
}
