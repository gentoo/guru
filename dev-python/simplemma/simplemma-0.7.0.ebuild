# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} )
inherit distutils-r1

DESCRIPTION="A simple multilingual lemmatizer for Python."
HOMEPAGE="https://github.com/adbar/simplemma https://pypi.org/project/simplemma/"
SRC_URI="https://github.com/adbar/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

DOCS=( HISTORY.rst README.rst )

distutils_enable_tests pytest
