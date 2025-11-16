# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Fully featured CD ripping program able to take out most of the tedium"
HOMEPAGE="https://github.com/cyanreg/cyanrip"
SRC_URI="https://github.com/cyanreg/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="mirror"

DEPEND="
dev-libs/libcdio-paranoia
media-video/ffmpeg
media-libs/musicbrainz
net-misc/curl"
RDEPEND="${DEPEND}"
