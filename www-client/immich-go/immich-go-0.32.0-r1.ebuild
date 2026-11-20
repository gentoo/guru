# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module shell-completion

DESCRIPTION="An alternative to immich-CLI that doesn't depend on nodejs installation"
HOMEPAGE="
	https://github.com/simulot/immich-go
"

# See https://bugs.gentoo.org/986659
SRC_URI="
	https://github.com/simulot/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://vimja.cloud/public.php/dav/files/z59eKDyLFokW2KK/${CATEGORY}/${PN}/${P}-vendor.tar.xz

"

# https://wiki.gentoo.org/wiki/Writing_go_Ebuilds#Licenses
LICENSE="AGPL-3"
LICENSE+=" Apache-2.0 BSD-2 BSD MIT "
SLOT="0"
KEYWORDS="~amd64 ~arm64"

IUSE="test"
RESTRICT="!test? ( test )"

BDEPEND="
	>=dev-lang/go-1.25.0
"

src_compile() {
	ego build ./...
	GOBIN="${S}/bin" ego install ./...

	"${GOBIN}"/${PN} completion bash > ${PN}
	"${GOBIN}"/${PN} completion zsh > _${PN}
	"${GOBIN}"/${PN} completion fish > ${PN}.fish
}

src_test() {
	ego test ./...
}

src_install() {
	dobin "${S}"/bin/${PN}

	dobashcomp ${PN}
	dozshcomp _${PN}
	dofishcomp ${PN}.fish
}
