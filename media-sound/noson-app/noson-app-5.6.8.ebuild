# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit xdg cmake

DESCRIPTION="The essential to control music from your SONOS devices on Linux platforms"
HOMEPAGE="https://janbar.github.io/noson-app/index.html"
SRC_URI="https://github.com/janbar/noson-app/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="
	dev-libs/openssl:=
	dev-qt/qtcore:5
	dev-qt/qtdbus:5
	dev-qt/qtdeclarative:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtquickcontrols2:5
	dev-qt/qtsvg:5
	dev-qt/qttranslations:5
	dev-qt/qtwidgets:5
	dev-qt/qtxml:5
	media-libs/flac:=
	media-libs/libpulse
	sys-libs/zlib
"
RDEPEND="${DEPEND}"
