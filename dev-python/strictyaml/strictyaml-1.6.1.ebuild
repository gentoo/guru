# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} pypy3 )

inherit distutils-r1

DESCRIPTION="A type-safe YAML parser built atop ruamel.yaml"
HOMEPAGE="https://github.com/crdoconnor/strictyaml"
SRC_URI="https://github.com/crdoconnor/strictyaml/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

KEYWORDS="~amd64 ~x86"
LICENSE="MIT"
SLOT="0"

RDEPEND="dev-python/python-dateutil[${PYTHON_USEDEP}]"

DOCS=( CHANGELOG.md README.md docs )
