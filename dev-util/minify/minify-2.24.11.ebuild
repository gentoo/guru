# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit bash-completion-r1 go-module

DESCRIPTION="Go minifier for web formats"
HOMEPAGE="https://go.tacodewolff.nl/minify"
SRC_URI="
	https://github.com/tdewolff/minify/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://gitlab.com/api/v4/projects/69517529/packages/generic/${PN}/${PV}/${P}-deps.tar.xz
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

src_compile() {
	ego build \
		-ldflags "-s -w -X 'main.Version=${PV}'" -trimpath \
		-o _minify ./cmd/minify
}

src_test() {
	ego test ./...
}

src_install() {
	newbin _minify minify
	dobashcomp cmd/minify/bash_completion
}
