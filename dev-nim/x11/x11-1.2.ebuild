# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit nimble

DESCRIPTION="x11 wrapper for Nim"
HOMEPAGE="https://github.com/nim-lang/x11"
SRC_URI="https://github.com/nim-lang/x11/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"

SLOT="0"

KEYWORDS="~amd64"
IUSE="examples"

src_install() {
	nimble_src_install

	if use examples; then
		dodoc -r examples
	fi
}
