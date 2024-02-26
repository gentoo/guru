# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit check-reqs shell-completion

DESCRIPTION="CLI frontend client connects to Bitwarden comapatible password manager server"
HOMEPAGE="https://github.com/bitwarden/clients/tree/main/apps/cli"

BW_CLIENTS_COMMIT="a1a5c4b"
SRC_URI="
	https://github.com/bitwarden/clients/archive/refs/tags/cli-v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/rahilarious/gentoo-distfiles/releases/download/bitwarden-clients-${BW_CLIENTS_COMMIT}/deps.tar.xz -> bitwarden-clients-${BW_CLIENTS_COMMIT}.tar.xz
	https://github.com/rahilarious/gentoo-distfiles/releases/download/${P}/pkg-cache.tar.xz -> ${P}-pkg-cache.tar.xz
"

S="${WORKDIR}/clients-cli-v${PV}"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

# non-stripped binary is of 99M but works
# stripped  bianry is of 44M but doesnt work
RESTRICT='strip'

RDEPEND="!app-admin/bitwarden-cli-bin"
BDEPEND="
	net-libs/nodejs:0/18[npm]
"

QA_PRESTRIPPED="usr/bin/bw"

CHECKREQS_MEMORY=2G
CHECKREQS_DISK_BUILD=2G

pkg_pretend() {
	einfo ""
	einfo "#################################################"
	einfo "Precompiled alternative to this package is available:"
	einfo "        ${CATEGORY}/${PN}-bin"
	einfo "#################################################"
	einfo ""
	check-reqs_pkg_pretend
}

src_prepare() {
	default
	mv -v ../node_modules ./ || die
}

src_compile() {
	pushd apps/cli
	PKG_CACHE_PATH="${WORKDIR}"/.pkg-cache npm --verbose --offline run dist:lin \
		|| die "Build failed! Try prebuilt from upstream ${CATEGORY}/${PN}-bin"
	./dist/linux/bw completion --shell zsh > bw.zsh
}

src_install() {
	dobin apps/cli/dist/linux/bw
	newzshcomp apps/cli/bw.zsh _bw
}
