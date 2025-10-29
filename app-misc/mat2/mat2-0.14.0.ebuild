# Copyright 2020-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..14} )
PYTHON_REQ_USE="xml(+)"
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 optfeature verify-sig

DESCRIPTION="Metadata Anonymisation Toolkit: handy tool to trash your metadata"
HOMEPAGE="https://github.com/jvoisin/mat2"
SRC_URI="
	https://github.com/jvoisin/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz
	verify-sig? ( https://github.com/jvoisin/${PN}/releases/download/${PV}/${PV}.tar.gz.asc -> ${P}.tar.gz.asc )
"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	app-text/poppler[introspection,cairo]
	dev-libs/glib:2
	dev-python/pycairo:0[${PYTHON_USEDEP}]
	dev-python/pygobject:3[cairo,${PYTHON_USEDEP}]
	gnome-base/librsvg[introspection]
	gui-libs/gdk-pixbuf-loader-webp
	media-libs/mutagen:0[${PYTHON_USEDEP}]
	x11-libs/gdk-pixbuf:2[introspection,jpeg,tiff]
"
BDEPEND="
	verify-sig? ( >sec-keys/openpgp-keys-jvoisin-20230224-r9999 )
	test? (
		media-libs/exiftool:*
		media-video/ffmpeg[lame,vorbis]
	)
"

VERIFY_SIG_OPENPGP_KEY_PATH=/usr/share/openpgp-keys/jvoisin.asc

DOCS=( doc {CHANGELOG,CONTRIBUTING,INSTALL,README}.md )

distutils_enable_tests unittest

src_prepare() {
	sed -i '/data_files/d' setup.py || die
	distutils-r1_src_prepare
}

src_install() {
	distutils-r1_src_install
	doman doc/mat2.1
}

pkg_postinst() {
	optfeature "misc file format support" media-libs/exiftool
	optfeature "video support" media-video/ffmpeg
}
