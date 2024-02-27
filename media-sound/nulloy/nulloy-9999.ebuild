# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 xdg

DESCRIPTION="Music player with a waveform progress bar (sound visualization)"
HOMEPAGE="https://nulloy.com"

EGIT_REPO_URI="https://github.com/nulloy/nulloy"
EGIT_CLONE_TYPE="shallow"

LICENSE="GPL-3"
SLOT="0"
IUSE="+skins"

BDEPEND="
	dev-qt/linguist-tools
	app-arch/zip
"

DEPEND="
	dev-qt/qtcore
	dev-qt/designer
	dev-qt/qtsvg
	dev-qt/linguist
	dev-qt/qtscript
	dev-qt/qtx11extras
	media-libs/gstreamer
	media-libs/gst-plugins-base
	media-libs/taglib
	media-plugins/gst-plugins-meta
	media-gfx/imagemagick[svg]
"
RDEPEND="${DEPEND}"

src_unpack() {
	git-r3_src_unpack

	if use skins ; then
		EGIT_REPO_URI=https://gitlab.com/vitaly-zdanevich/nulloy-theme-night.git
		EGIT_CHECKOUT_DIR="${WORKDIR}/night"
		git-r3_src_unpack
	fi
}

src_prepare() {
	default

	if use skins ; then
		eapply "${FILESDIR}/add-dark-theme.patch"
		cp -r "${WORKDIR}/night" src/skins
	fi
}

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

	QMAKE=/usr/bin/qmake5 LRELEASE=/usr/lib64/qt5/bin/lrelease ./configure "${myconfargs[@]}" || die

	# Because stripping should not be done by the build tools,
	# because Portage does it when the install phase is run to be able
	# to support the `splitdebug` and `installsources` FEATURES.
	# See related issue https://bugs.gentoo.org/856292
	echo "CONFIG += nostrip" >> "${WORKDIR}/${P}/.qmake.cache"
}

src_install() {
	emake INSTALL_ROOT="${ED}" install
	einstalldocs
}
