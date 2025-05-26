# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit xdg qmake-utils edo

DESCRIPTION="Music player with a waveform progress bar (sound visualization)"
HOMEPAGE="https://nulloy.com"

SRC_URI="https://github.com/nulloy/nulloy/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+skins"

BDEPEND="
	app-arch/zip
"

DEPEND="
	dev-qt/qtcore:5
	dev-qt/designer:5
	dev-qt/qtsvg:5
	dev-qt/qtscript:5
	dev-qt/qtx11extras:5
	media-gfx/imagemagick[svg]
	media-libs/gstreamer
	media-libs/gst-plugins-base
	media-libs/taglib
	media-plugins/gst-plugins-meta
"
RDEPEND="${DEPEND}"

src_configure() {
	# Upstream ./configure script does not support specifying an option's
	# value after an equal sign like in '--prefix="${EPREFIX}/usr"', so we
	# have to set up all the options ourselves and call the script directly
	local myconfargs=(
		$(use skins || echo --no-skins)
		--no-update-check
		--gstreamer-tagreader
		--prefix "${EPREFIX}/usr"
		--libdir "$(get_libdir)"
	)

	QMAKE="$(qt5_get_bindir)/qmake" LRELEASE="$(qt5_get_bindir)/lrelease" edo ./configure "${myconfargs[@]}"

	# Because stripping should not be done by the build tools,
	# because Portage does it when the install phase is run to be able
	# to support the `splitdebug` and `installsources` FEATURES.
	# See related issue https://bugs.gentoo.org/856292
	edo echo "CONFIG += nostrip" >> "${WORKDIR}/${P}/.qmake.cache"
}

src_install() {
	emake INSTALL_ROOT="${ED}" install
	einstalldocs
}
