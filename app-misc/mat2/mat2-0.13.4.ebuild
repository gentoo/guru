# Copyright 2020-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )
PYTHON_REQ_USE="xml(+)"
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 optfeature verify-sig

DESCRIPTION="Metadata Anonymisation Toolkit: handy tool to trash your metadata"
HOMEPAGE="https://0xacab.org/jvoisin/mat2"
SIG_UPLOAD_HASH="95d1f3782dfc731545fd9b467c594cb2"
SRC_URI="
	https://0xacab.org/jvoisin/${PN}/-/archive/${PV}/${P}.tar.gz
	verify-sig? ( https://0xacab.org/jvoisin/${PN}/uploads/${SIG_UPLOAD_HASH}/${P}.tar.gz.asc )
"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64"

# Fixed in bbd5b2817c9d64013e2f5ed670aca8d4738bb484
RESTRICT="test"

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
	verify-sig? ( >sec-keys/openpgp-keys-jvoisin-20200714 )
	test? (
		media-libs/exiftool:*
		media-video/ffmpeg[mp3,vorbis]
	)
"

VERIFY_SIG_OPENPGP_KEY_PATH=/usr/share/openpgp-keys/jvoisin.asc

DOCS=( doc {CHANGELOG,CONTRIBUTING,INSTALL,README}.md )

distutils_enable_tests unittest

src_test() {
	# Double sandboxing is not possible
	if ! has usersandbox ${FEATURES}; then
		distutils-r1_src_test
	fi
	return 0
}

pkg_postinst() {
	optfeature "misc file format support" media-libs/exiftool
	optfeature "sandboxing" sys-apps/bubblewrap
	optfeature "video support" media-video/ffmpeg
}
