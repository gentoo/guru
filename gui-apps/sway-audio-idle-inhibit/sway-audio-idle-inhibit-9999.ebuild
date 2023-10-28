# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 meson

DESCRIPTION="Prevents swayidle from idle when an application is outputting or receiving audio"
HOMEPAGE="https://github.com/ErikReider/SwayAudioIdleInhibit"
EGIT_REPO_URI="https://github.com/ErikReider/SwayAudioIdleInhibit.git"

LICENSE="GPL-3"
SLOT="0/9999"

DEPEND="
	dev-libs/wayland
	dev-libs/wayland-protocols
	media-libs/libpulse
"
RDEPEND="${DEPEND}"
