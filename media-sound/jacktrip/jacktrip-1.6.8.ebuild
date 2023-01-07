# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Send JACK audio over a network"
HOMEPAGE="https://jacktrip.github.io/jacktrip/ https://github.com/jacktrip/jacktrip"
SRC_URI="https://github.com/jacktrip/jacktrip/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+gui jack +rtaudio virtualstudio"
REQUIRED_USE="
	virtualstudio? ( gui )
	|| ( jack rtaudio )
"

DEPEND="
	dev-qt/qtcore:5=
	dev-qt/qtnetwork:5=

	gui? (
		dev-qt/qtgui:5=
		dev-qt/qtwidgets:5=
	)

	jack? (
		virtual/jack
	)

	rtaudio? (
		media-libs/rtaudio:=
	)

	virtualstudio? (
		dev-qt/qtdeclarative:5=
		dev-qt/qtnetworkauth:5=
		dev-qt/qtsvg:5=
		dev-qt/qtwebsockets:5=
	)
"
RDEPEND="${DEPEND}"

src_configure() {
	local emesonargs=(
		-Dweakjack=false
		-Dnoupdater=true
		-Dnogui=$(usex gui false true)
		-Dnovs=$(usex virtualstudio false true)
		$(meson_feature jack)
		$(meson_feature rtaudio)
	)

	meson_src_configure
}
