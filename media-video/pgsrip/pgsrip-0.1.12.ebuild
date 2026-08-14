# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=poetry

inherit distutils-r1

DESCRIPTION="A command line tool to extract and convert PGS subtitles into SRT format"
HOMEPAGE="https://github.com/ratoaq2/pgsrip"
SRC_URI="https://github.com/ratoaq2/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="mirror"

RDEPEND="
app-text/tesseract
dev-python/babelfish
dev-python/click
dev-python/pysrt
dev-python/pytesseract
dev-python/numpy
dev-python/trakit
media-libs/opencv[python]
media-video/cleanit
media-video/mkvtoolnix"
BDEPEND="${PYTHON_DEPS}"
