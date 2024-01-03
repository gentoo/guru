# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit optfeature

DESCRIPTION="Community-maintained extensions for hyprland"
HOMEPAGE="https://hyprland.org/"
if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/hyprwm/contrib.git"
	inherit git-r3
else
	SRC_URI="https://github.com/hyprwm/contrib/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/contrib-${PV}"
	KEYWORDS="~amd64"
fi

LICENSE="MIT"
SLOT="0"
IUSE="+grimblast +hyprprop +scratchpad +shellevents +swap"

RDEPEND="
	app-shells/bash
	gui-wm/hyprland
	grimblast? (
		gui-apps/wl-clipboard
		gui-apps/grim
		app-misc/jq
		gui-apps/slurp
		app-misc/jq
	)
	hyprprop? (
		app-misc/jq
		gui-apps/slurp
	)
	scratchpad? (
		sys-apps/sed
		app-misc/jq
		gui-apps/slurp
		app-misc/jq
	)
"
BDEPEND="
	grimblast? (
		app-text/scdoc
	)
	hyprprop? (
		app-text/scdoc
	)
"
DEPEND="${RDEPEND}"

S="${WORKDIR}/contrib-${PV}"
src_install() {
	if use grimblast; then
	   pushd grimblast || die
	   PREFIX="${D}/usr" emake install
	   popd || die
	fi
	if use hyprprop; then
	   pushd hyprprop || die
	   PREFIX="${D}/usr" emake install
	   popd || die
	fi
	if use scratchpad; then
	   pushd scratchpad || die
	   PREFIX="${D}/usr" emake install
	   popd || die
	fi
	if use shellevents; then
	   pushd shellevents || die
	   PREFIX="${D}/usr" emake install
	   popd || die
	fi
	if use swap; then
	   pushd try_swap_workspace || die
	   PREFIX="${D}/usr" emake install
	   popd || die
	fi
}

pkg_postinst() {
	if use grimblast || use hyprprop || use scratchpad || use swap; then
		optfeature "GUI notifications during dependency checks" x11-libs/libnotify
	fi
}
