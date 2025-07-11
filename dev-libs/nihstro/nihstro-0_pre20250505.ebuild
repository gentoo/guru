# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

EGIT_COMMIT="f4d8659decbfe5d234f04134b5002b82dc515a44"

DESCRIPTION="3DS shader assembler and disassembler"
HOMEPAGE="https://github.com/neobrain/nihstro"
SRC_URI="https://github.com/neobrain/nihstro/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/${PN}-${EGIT_COMMIT}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-libs/boost:="

src_configure() {
	local mycmakeargs=(
		-Wno-dev
	)

	cmake_src_configure
}

src_install() {
	cmake_src_install

	doheader -r include/nihstro
}
