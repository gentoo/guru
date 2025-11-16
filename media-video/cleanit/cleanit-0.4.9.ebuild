# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=poetry

inherit distutils-r1

DESCRIPTION="A command line tool that helps you to keep your subtitles clean"
HOMEPAGE="https://github.com/ratoaq2/cleanit"
SRC_URI="https://github.com/ratoaq2/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="mirror"

distutils_enable_tests pytest

RDEPEND="
dev-python/appdirs
dev-python/babelfish
dev-python/chardet
dev-python/click
dev-python/jsonschema
dev-python/pysrt
dev-python/pyyaml"
BDEPEND="${PYTHON_DEPS}
test? ( dev-python/flake8 )"
