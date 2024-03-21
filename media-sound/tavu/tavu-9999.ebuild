# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 meson

DESCRIPTION="Terminal-based ALSA VU-meter with peaking"
HOMEPAGE="https://git.sr.ht/~kennylevinsen/tavu"
EGIT_REPO_URI="https://git.sr.ht/~kennylevinsen/tavu"
LICENSE="MIT"
SLOT="0"

DEPEND="media-libs/alsa-lib"
RDEPEND="${DEPEND}"
