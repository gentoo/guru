# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=(python3_{8..11})
PYTHON_REQ_USE="xml(+)"
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 optfeature verify-sig

DESCRIPTION="Metadata Anonymisation Toolkit: handy tool to trash your metadata"
HOMEPAGE="https://0xacab.org/jvoisin/mat2"
SRC_URI="
	https://0xacab.org/jvoisin/${PN}/-/archive/${PV}/${P}.tar.gz
	verify-sig? ( https://0xacab.org/jvoisin/mat2/uploads/b8b7bce2a45aa6c1b2b48432025b2fef/mat2-0.13.0.tar.gz.asc )
"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/pycairo:0[${PYTHON_USEDEP}]
	dev-python/pygobject:3[${PYTHON_USEDEP}]
	media-libs/mutagen:0[${PYTHON_USEDEP}]
"
BDEPEND="
	verify-sig? ( sec-keys/openpgp-keys-jvoisin )
	test? (
		app-text/poppler[introspection(+)]
		gnome-base/librsvg[introspection(+)]
		media-libs/exiftool:*
		media-video/ffmpeg[mp3(+),vorbis(+)]
		x11-libs/gdk-pixbuf:2[jpeg(+),tiff(+)]
	)
"

VERIFY_SIG_OPENPGP_KEY_PATH="${BROOT}"/usr/share/openpgp-keys/jvoisin.asc

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
