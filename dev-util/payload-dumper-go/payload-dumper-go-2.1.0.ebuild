# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="an android OTA payload dumper written in Go"
HOMEPAGE="https://github.com/ssut/payload-dumper-go"
SRC_URI="
	https://github.com/ssut/payload-dumper-go/archive/${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/yamader/gentoo-deps/releases/download/${P}/${P}-deps.tar.xz
"

LICENSE="Apache-2.0 BSD MIT Unlicense"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="app-arch/xz-utils"
RDEPEND="${DEPEND}"
BDEPEND=">=dev-lang/go-1.27.0"

DOCS=( CHANGELOG.md README.md )

src_prepare() {
	# https://bugs.gentoo.org/982180
	cd "${WORKDIR}"/go-mod/github.com/valyala/gozstd@v1.26.0 && eapply "${FILESDIR}"/gozstd-cgo-flags.patch
	eapply_user
}

src_compile() {
	ego build
}

src_install() {
	dobin payload-dumper-go
	einstalldocs
}
