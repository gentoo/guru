# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} pypy3 )

inherit distutils-r1

DESCRIPTION="A type-safe YAML parser built atop ruamel.yaml"
HOMEPAGE="https://github.com/crdoconnor/strictyaml"
SRC_URI="https://github.com/crdoconnor/strictyaml/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

KEYWORDS="~amd64 ~x86"
LICENSE="MIT"
SLOT="0"

RDEPEND="
	dev-python/ruamel-yaml[${PYTHON_USEDEP}]
	dev-python/python-dateutil[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"
