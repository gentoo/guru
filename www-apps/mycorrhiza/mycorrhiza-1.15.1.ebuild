# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="Git-based wiki engine written in Go using mycomarkup"
HOMEPAGE="https://mycorrhiza.wiki"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/bouncepaw/mycorrhiza"
	inherit git-r3
else
	SRC_URI="
		https://github.com/bouncepaw/mycorrhiza/archive/v${PV}.tar.gz -> ${P}.tar.gz
		https://codeberg.org/BratishkaErik/distfiles/releases/download/mycorrhiza-${PV}/mycorrhiza-${PV}-vendor.tar.xz
	"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="AGPL-3 MIT Apache-2.0 BSD BSD-2 CC-BY-4.0"
SLOT="0"

RESTRICT="mirror"

BDEPEND=">=dev-lang/go-1.22"
RDEPEND="dev-vcs/git"

DOCS=( "README.md" )

src_unpack() {
	if [[ ${PV} == 9999 ]]; then
		git-r3_src_unpack
		go-module_live_vendor
	fi
	go-module_src_unpack
}

src_compile() {
	GOFLAGS+=" -mod=vendor -trimpath"
	local go_ldflags="-s -linkmode external -extldflags \"${LDFLAGS}\""
	ego build ${GOFLAGS} -ldflags="${go_ldflags}" .
}

src_install() {
	dobin mycorrhiza

	einstalldocs
	doman help/mycorrhiza.1
}

pkg_postinst() {
	elog "Quick start: mycorrhiza /your/wiki/directory"
	elog
	elog "It will initialize a Git repository, set useful default settings"
	elog "And run a server on http://localhost:1737"
	elog "More information here: https://mycorrhiza.wiki/"
	elog "Also your wiki has built-in documentation :)"
	elog "You can view this documentation at http://localhost:1737/help"
}
