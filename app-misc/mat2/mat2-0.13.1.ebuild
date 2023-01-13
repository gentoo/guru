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
	verify-sig? ( https://0xacab.org/jvoisin/mat2/uploads/5058fa3903cf7c9dec8f262018669bec/mat2-0.13.1.tar.gz.asc )
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
	media-libs/mutagen:0[${PYTHON_USEDEP}]
	x11-libs/gdk-pixbuf:2[introspection,jpeg,tiff]
"
BDEPEND="
	verify-sig? ( sec-keys/openpgp-keys-jvoisin )
	test? (
		media-libs/exiftool:*
		media-video/ffmpeg[mp3,vorbis]
	)
"

VERIFY_SIG_OPENPGP_KEY_PATH="${BROOT}"/usr/share/openpgp-keys/jvoisin.asc

DOCS=( doc {CHANGELOG,CONTRIBUTING,INSTALL,README}.md )

distutils_enable_tests unittest

pkg_postinst() {
	optfeature "misc file format support" media-libs/exiftool
	optfeature "sandboxing" sys-apps/bubblewrap
	optfeature "video support" media-video/ffmpeg
}
