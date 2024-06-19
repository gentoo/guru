# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Mustache implementation for modern C++"
HOMEPAGE="https://github.com/kainjow/Mustache"
SRC_URI="https://github.com/kainjow/$PN/archive/v$PV.tar.gz -> $P.tar.gz"

S="${WORKDIR}/Mustache-${PV}"
LICENSE="Boost-1.0"
SLOT="0"
KEYWORDS="~amd64"

src_compile() {
	:
}

src_install() {
	insinto /usr/include
	doins mustache.hpp
}
