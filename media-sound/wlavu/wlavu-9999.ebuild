# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 meson

DESCRIPTION="Wayland-based ALSA VU-meter with peaking and optionnal support for wlr-layer-shell"
HOMEPAGE="https://git.sr.ht/~kennylevinsen/wlavu"
EGIT_REPO_URI="https://git.sr.ht/~kennylevinsen/wlavu"
LICENSE="MIT"
SLOT="0"
KEYWORDS=""

DEPEND="
	media-video/pipewire:=
	dev-libs/wayland
"
RDEPEND="${DEPEND}"
