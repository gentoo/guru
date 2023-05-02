# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Community-maintained extensions for hyprland"
HOMEPAGE="https://hyprland.org/"
SRC_URI="https://github.com/hyprwm/contrib/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="
	app-shells/bash
"
DEPEND="${RDEPEND}
"

S="${WORKDIR}/contrib-${PV}"
src_install() {
	pushd grimblast || die
	PREFIX="${D}/usr" emake install
	popd || die
	pushd hyprprop || die
	PREFIX="${D}/usr" emake install
	popd || die
	pushd scratchpad || die
	PREFIX="${D}/usr" emake install
	popd || die
	pushd shellevents || die
	PREFIX="${D}/usr" emake install
	popd || die
	pushd try_swap_workspace || die
	PREFIX="${D}/usr" emake install
	popd || die
}
