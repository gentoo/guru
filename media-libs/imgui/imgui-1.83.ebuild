# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Bloat-free graphical user interface library for C++"
HOMEPAGE="https://github.com/ocornut/imgui"
SRC_URI="https://github.com/ocornut/imgui/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="examples"

RDEPEND="media-libs/glew:0"
DEPEND="${RDEPEND}"

src_install() {
	dodoc docs/*
	insinto "/usr/include/${PN}"
	doins *.h
	doins -r misc/*/*.h
	insinto "/usr/include/${PN}/backend"
	doins backends/*.h
	insinto "/usr/share/${PN}"
	doins *.cpp
	insinto "/usr/share/${PN}/backend"
	doins backends/*.cpp
	doins -r backends/vulkan
	rm -r misc/*/*.{h,ttf} || die
	doins -r misc

	if use examples; then
		dodoc -r examples
		docompress -x "/usr/share/doc/${PF}/examples"
	fi
}
