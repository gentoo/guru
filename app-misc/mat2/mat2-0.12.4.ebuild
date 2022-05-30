# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=(python3_{8..10})
PYTHON_REQ_USE="xml"

inherit distutils-r1 optfeature

DESCRIPTION="Metadata Anonymisation Toolkit: handy tool to trash your metadata"
HOMEPAGE="https://0xacab.org/jvoisin/mat2"
SRC_URI="https://0xacab.org/jvoisin/${PN}/-/archive/${PV}/${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/pycairo:0[${PYTHON_USEDEP}]
	dev-python/pygobject:3[${PYTHON_USEDEP}]
	media-libs/mutagen:0[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		media-libs/exiftool:*
		media-video/ffmpeg[mp3,vorbis]
		x11-libs/gdk-pixbuf:2[jpeg,tiff]
	)
"

DOCS=( doc {CHANGELOG,CONTRIBUTING,INSTALL,README}.md )

distutils_enable_tests unittest

pkg_postinst() {
	optfeature "PDF support" "app-text/poppler[introspection]"
	optfeature "SVG support" "gnome-base/librsvg:2[introspection]"
	optfeature "image support" "x11-libs/gdk-pixbuf:2[introspection]"
	optfeature "misc file format support" media-libs/exiftool
	optfeature "sandboxing" sys-apps/bubblewrap
	optfeature "video support" media-video/ffmpeg
}
