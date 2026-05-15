# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit bash-completion-r1 go-module

DESCRIPTION="Go minifier for web formats"
HOMEPAGE="https://go.tacodewolff.nl/minify"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/tdewolff/minify.git"
else
	SRC_URI="
		https://github.com/tdewolff/minify/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
		https://github.com/tdewolff/minify/releases/download/v${PV}/${PN}-deps.tar.xz -> ${P}-deps.tar.xz
	"
	KEYWORDS="~amd64"
	RESTRICT="mirror"
fi

LICENSE="MIT"
SLOT="0"

BDEPEND=">=dev-lang/go-1.25.0"

src_unpack() {
	if [[ "${PV}" == 9999 ]] ; then
		git-r3_src_unpack
		go-module_live_vendor
	else
		default
	fi
}

src_compile() {
	ego build -trimpath -buildmode=pie -mod=readonly -modcacherw -ldflags \
		"-s -w -linkmode external -extldflags \"${LDFLAGS}\" -X 'main.Version=${PV}'" \
		-o _minify ./cmd/minify
}

src_test() {
	ego test ./...
}

src_install() {
	newbin _minify minify
	newbashcomp cmd/minify/bash_completion minify
}
