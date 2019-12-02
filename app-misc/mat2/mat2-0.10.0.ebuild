# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# Supports python3_8 but not all it's deps in the tree do yet
PYTHON_COMPAT=(python3_{5,6,7})
PYTHON_REQ_USE="xml"

inherit distutils-r1

DESCRIPTION="Metadata Anonymisation Toolkit: handy tool to trash your metadata"
HOMEPAGE="https://0xacab.org/jvoisin/mat2"
LICENSE="LGPL-3"
SLOT="0"
SRC_URI="https://0xacab.org/jvoisin/mat2/-/archive/${PV}/${P}.tar.gz"
KEYWORDS="~amd64"
IUSE="+exif sandbox video test"
REQUIRED_USE="${PYTHON_REQUIRED_USE} test? ( exif video )"
RESTRICT="!test? ( test )"

DEPEND="${PYTHON_DEPS}"
RDEPEND="
	${DEPEND}
	media-libs/mutagen:0[${PYTHON_USEDEP}]
	dev-python/pycairo:0[${PYTHON_USEDEP}]
	dev-python/pygobject:3[${PYTHON_USEDEP}]
	gnome-base/librsvg:2[introspection]
	x11-libs/gdk-pixbuf:2[introspection]
	app-text/poppler[introspection]
	exif? ( media-libs/exiftool:* )
	sandbox? ( sys-apps/bubblewrap )
	video? ( media-video/ffmpeg:* )
	test? (
		media-video/ffmpeg[mp3,vorbis]
		x11-libs/gdk-pixbuf:2[jpeg,tiff]
	)
"

distutils_enable_tests unittest
