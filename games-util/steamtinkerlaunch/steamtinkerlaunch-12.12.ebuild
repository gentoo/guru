# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit optfeature xdg

DESCRIPTION="Wrapper script for Steam custom launch options"
HOMEPAGE="https://github.com/sonic2kk/steamtinkerlaunch"
if [ "${PV}" == 9999 ] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/sonic2kk/${PN}"
else
	SRC_URI="https://github.com/sonic2kk/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi
LICENSE="GPL-3"
SLOT="0"
RESTRICT="test"

BDEPEND="
	app-alternatives/awk
	app-shells/bash
	dev-vcs/git
	app-arch/unzip
	net-misc/wget
	x11-misc/xdotool
	x11-apps/xprop
	x11-apps/xrandr
	|| ( app-editors/vim-core dev-util/xxd )
	x11-apps/xwininfo
	>=gnome-extra/yad-7.2
"

src_prepare() {
	default

	sed -i \
		-e 's|PREFIX := /usr|PREFIX := $(DESTDIR)/usr|' \
		-e "s|share/doc/${PN}|share/doc/${PF}|" \
		-e '/sed "s:^PREFIX=/d' \
		Makefile
}

pkg_postinst() {
	xdg_pkg_postinst

	optfeature_header "Optional programs for additional features:"
	optfeature "running DOSBox games natively." games-engines/boxtron
	optfeature "optimizing games with a configurable tool." games-util/gamemode
	optfeature "running games in an insolated Xwayland instance." gui-wm/gamescope
	optfeature "debugging programs from GNU." sys-devel/gdb
	optfeature "Game Icons for Game Desktop Files." media-gfx/imagemagick
	optfeature "JSON Parser utility. Used to get updated Proton versions for Vortex and other things.\
			Highly recommended." app-misc/jq
	optfeature "sending desktop notifications. A custom notifier may be defined." x11-libs/libnotify
	optfeature "monitoring performance metrics such as FPS, temperatures, CPU/GPU load and more." games-util/mangohud
	optfeature "game network activity monitoring." sys-apps/net-tools
	optfeature "putting games and applications to sleep to free up resources." x11-misc/nyrna-bin
	optfeature "extracting SpecialK archives." app-arch/p7zip
	optfeature "extracting data from game executables." app-misc/pev
	optfeature "backing up and restoring the steamuser folder of a Proton prefix." net-misc/rsync
	optfeature "starting ScummVM games natively via Roberta." games-engines/scummvm
	optfeature "writing game logs." dev-util/strace
	optfeature "checking if a VR headset is present." sys-apps/usbutils
	optfeature "vulkan post-processing (shader) layer similar to and \
			 mostly compatible with ReShade shaders." games-util/vkbasalt
	optfeature "playing stereoscopic videos, regular videos \
			and games in VR." media-gfx/vr-video-player
	optfeature "running applications with system Wine and performing \
			associated Wine configurations." app-emulation/wine-vanilla
	optfeature "installing Winetricks workarounds/verbs on Wine/Proton prefixes." app-emulation/winetricks
	optfeature "desktop environment application integration, such as \
			opening default browsers or text editors." x11-misc/xdg-utils

	ewarn ""
	ewarn "This is the latest stable release of this package."
	ewarn "It has LOTS of bugs and is currently UNSUPPORTED by upstream!"
	ewarn "Users are STRONGLY encouraged to use the -9999 version of this package."

}

pkg_postrm() {
	xdg_pkg_postrm
}
