# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="Shell script formatter"
HOMEPAGE="https://github.com/mvdan/sh"
if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/mvdan/sh.git"
	RESTRICT="fetch mirror test"
else
	SRC_URI="https://github.com/mvdan/sh/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
	SRC_URI+=" ${P}-deps.tar.xz"
	KEYWORDS="~amd64 ~arm64 ~x86"
	RESTRICT="mirror test"
	S="${WORKDIR}/${PN/fmt}-${PV}"
fi

LICENSE="MIT"
SLOT="0"
IUSE="+man"

BDEPENDS="
	dev-lang/go
	man? ( app-text/scdoc )
"

src_unpack() {
	default
	if [[ ${PV} == *9999 ]]; then
		git-r3_fetch
		git-r3_checkout
		pushd ${P}/cmd/shfmt || die "location change for module building failed"
		ego get
		popd || die "location reset from module building failed"
	else
		mv mvdan-sh-* || die "correct placement of directory failed"
		go-module_src_unpack
	fi
}

src_compile() {
	ego build -v -ldflags "-s -w" -o "${PN}" "./cmd/shfmt"
	if use man; then
		scdoc < cmd/shfmt/shfmt.1.scd > shfmt.1 || die "conversation of man page failed"
	fi
}

src_install() {
	dobin ${PN}
	if use man; then
		doman shfmt.1
	fi
}
