# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{3_7,3_8,3_9} )
inherit distutils-r1

DESCRIPTION="Kitchen contains a cornucopia of useful code"
HOMEPAGE="https://github.com/fedora-infra/kitchen"
SRC_URI="https://github.com/fedora-infra/kitchen/archive/${PV}.tar.gz"

S="${WORKDIR}/${P}"

LICENSE="LGPL-2.1"

SLOT="0"

KEYWORDS="~amd64"

src_prepare() {
    distutils-r1_src_prepare
}
