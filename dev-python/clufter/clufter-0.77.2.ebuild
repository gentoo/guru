# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{7,8,9} )

inherit distutils-r1

DESCRIPTION="Tool/library for transforming/analyzing cluster configuration formats"
HOMEPAGE="https://pagure.io/clufter"
SRC_URI="https://pagure.io/clufter/archive/v0.77.2/clufter-v0.77.2.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/lxml
		dev-libs/libxml2"

S="${WORKDIR}/${PN}-v${PV}"
