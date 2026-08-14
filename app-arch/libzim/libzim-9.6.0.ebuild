# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# TODO: add tests, doc
# TODO: add optional +xapian USE

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )

inherit meson python-any-r1

DESCRIPTION="ZIM file format: an offline storage solution for content coming from the Web"
HOMEPAGE="https://wiki.openzim.org/wiki/OpenZIM"
SRC_URI="https://github.com/openzim/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0/9.5"
KEYWORDS="~amd64"

RDEPEND="
	app-arch/lzma
	app-arch/xz-utils
	app-arch/zstd:=
	dev-libs/icu:=
	dev-libs/xapian:=
"
DEPEND="${RDEPEND}"
BDEPEND="${PYTHON_DEPS}"
