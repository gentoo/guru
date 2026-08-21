# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module optfeature

DESCRIPTION="Vim-inspired multi-pane terminal front-end for GDB and Delve"
HOMEPAGE="https://github.com/yairgd/gdbforge"
SRC_URI="https://github.com/yairgd/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/yairgd/${PN}/releases/download/v${PV}/${P}-vendor.tar.xz
"

LICENSE="MIT"
# Go dependency licenses (see dev-go/lichen)
LICENSE+=" Apache-2.0 BSD BSD-3-Clause MIT OFL-1.1"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="test"

RDEPEND="dev-debug/gdb"
BDEPEND=">=dev-lang/go-1.25.0"

DOCS=( README.md CONTRIBUTING.md )

src_compile() {
	local go_ldflags=(
		-X "main.version=v${PV}"
	)

	ego build -ldflags "${go_ldflags[*]}" ./cmd/gdbforge
}

src_install() {
	dobin gdbforge
	einstalldocs
}

pkg_postinst() {
	optfeature "Go debugging via Delve" dev-debug/delve
	optfeature "X11 PRIMARY/CLIPBOARD via xclip" x11-misc/xclip
}
