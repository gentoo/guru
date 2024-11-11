# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..13} )
inherit python-any-r1 xdg meson

DESCRIPTION="Send JACK audio over a network"
HOMEPAGE="https://jacktrip.github.io/jacktrip/ https://github.com/jacktrip/jacktrip"
SRC_URI="https://github.com/jacktrip/jacktrip/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="gui jack +rtaudio virtualstudio"
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
# shellcheck disable=SC2016
BDEPEND="
	$(python_gen_any_dep '
		dev-python/jinja2[${PYTHON_USEDEP}]
		dev-python/pyyaml[${PYTHON_USEDEP}]
	')
"

python_check_deps() {
	python_has_version "dev-python/jinja2[${PYTHON_USEDEP}]" && \
	python_has_version "dev-python/pyyaml[${PYTHON_USEDEP}]"
}

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
