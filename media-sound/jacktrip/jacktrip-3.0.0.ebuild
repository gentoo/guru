# Copyright 2023-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )
inherit python-any-r1 meson xdg

DESCRIPTION="Send JACK audio over a network"
HOMEPAGE="https://jacktrip.github.io/jacktrip/ https://github.com/jacktrip/jacktrip"
SRC_URI="https://github.com/jacktrip/jacktrip/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="gui jack +libsamplerate +rtaudio virtualstudio"
REQUIRED_USE="
	virtualstudio? ( gui )
	|| ( jack rtaudio )
"

DEPEND="
	dev-qt/qtbase:6[network,ssl]
	gui? ( dev-qt/qtbase:6[gui,widgets] )
	jack? ( virtual/jack )
	libsamplerate? ( media-libs/libsamplerate )
	rtaudio? ( media-libs/rtaudio:= )
	virtualstudio? (
		dev-qt/qt5compat:6[qml]
		dev-qt/qtdeclarative:6
		dev-qt/qtshadertools:6
		dev-qt/qtsvg:6
		dev-qt/qtwebchannel:6
		dev-qt/qtwebengine:6[qml]
		dev-qt/qtwebsockets:6
	)
"
RDEPEND="${DEPEND}"
# shellcheck disable=SC2016
BDEPEND="
	sys-apps/help2man
	virtual/pkgconfig

	$(python_gen_any_dep '
		dev-python/jinja2[${PYTHON_USEDEP}]
		dev-python/pyyaml[${PYTHON_USEDEP}]
	')
"

python_check_deps() {
	python_has_version "dev-python/jinja2[${PYTHON_USEDEP}]" && \
	python_has_version "dev-python/pyyaml[${PYTHON_USEDEP}]"
}

src_prepare() {
	default

	# don't compress manpages
	sed -i -e "/gzip = /s:find_program(.*):disabler():" meson.build || die
}

src_configure() {
	local emesonargs=(
		-Dbuildinfo="gentoo${PR}"
		-Dnoupdater=true
		-Dqtversion=6
		-Dweakjack=false
		$(meson_use !gui nogui)
		$(meson_use !virtualstudio novs)
		$(meson_feature jack)
		$(meson_feature libsamplerate)
		$(meson_feature rtaudio)
	)

	meson_src_configure
}
