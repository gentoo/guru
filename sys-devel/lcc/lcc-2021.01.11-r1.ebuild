# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

# Would allow installing gentoo on any arch.
DESCRIPTION="The lcc retargetable ANSI C compiler"
HOMEPAGE="https://drh.github.io/lcc/"
SHA='3fd0acc0c3087411c0966d725a56be29038c05a9'
SRC_URI="https://github.com/drh/lcc/archive/${SHA}.tar.gz"

# Build using CMake, still missing some features.
PATCHES=( "${FILESDIR}/add_cmake_support.patch" )

LICENSE="lcc"
SLOT="0"
KEYWORDS="~amd64"

# What are the dependencies if any?
#DEPEND=""
#RDEPEND="${DEPEND}"
#BDEPEND=""
S="${WORKDIR}/${PN}-${SHA}"

src_install() {
        doman "doc/bprint.1"
        doman "doc/lcc.1"
        into "/usr/lib/lcc"
        dobin "${WORKDIR}/${PN}-${SHA}_build/cpp/cpp"
        dobin "${WORKDIR}/${PN}-${SHA}_build/etc/bprint"
        dobin "${WORKDIR}/${PN}-${SHA}_build/etc/lcc"
        dobin "${WORKDIR}/${PN}-${SHA}_build/lburg/lburg"
        dobin "${WORKDIR}/${PN}-${SHA}_build/src/rcc"
}

pkg_postinst() {
        ewarn "If you had installed the previous version of this ebuild (lcc-2021.01.11),"
        ewarn "there was a file collision that deleted the GNU's /usr/bin/cpp by LCC's own /usr/bin/cpp."
        ewarn "So make sure to run the following commands :"
        ewarn "gcc-config -l"
        ewarn "gcc-config -f the_gcc_config_of_the_previous_command"
        ewarn "The new package lcc-2021.01.11-r1 doesn't adds LCC to PATH anymore."
}