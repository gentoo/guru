# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
#
EAPI=8

DISTUTILS_USE_PEP517=setuptools
DISTUTILS_SINGLE_IMPL=1
PYTHON_COMPAT=( python3_{10..13} )

inherit desktop distutils-r1 optfeature xdg

MY_PN="WoeUSB-ng"
DESCRIPTION="Create Windows installer USB from ISO (rewrite of WoeUSB)"
HOMEPAGE="https://github.com/WoeUSB/WoeUSB-ng"
SRC_URI="https://github.com/WoeUSB/${MY_PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	!sys-boot/woeusb
	app-arch/p7zip
	$(python_gen_cond_dep '
		dev-python/termcolor[${PYTHON_USEDEP}]
	')
"

PATCHES=( "${FILESDIR}"/${PN}-0.2.12-postinstall.patch )

src_prepare() {
	distutils-r1_src_prepare
	python_fix_shebang WoeUSB
}

src_install() {
	distutils-r1_src_install
	dobin WoeUSB/woeusbgui

	insinto /usr/share/polkit-1/actions
	doins miscellaneous/com.github.woeusb.woeusb-ng.policy

	doicon -s 256 WoeUSB/data/woeusb-logo.png
	make_desktop_entry woeusbgui WoeUSB-ng woeusb-logo Utility
}

pkg_postinst() {
	optfeature "GUI support" dev-python/wxpython:4.0
	optfeature "Legacy PC bootmode support" "sys-boot/grub[grub_platforms_pc]"

	xdg_pkg_postinst
}
