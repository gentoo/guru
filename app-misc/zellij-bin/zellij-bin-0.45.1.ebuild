# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

inherit shell-completion

DESCRIPTION="A terminal workspace with batteries included"
HOMEPAGE="https://zellij.dev/"
SRC_URI="
	amd64? ( https://github.com/zellij-org/zellij/releases/download/v${PV}/${PN%-bin}-x86_64-unknown-linux-musl.tar.gz
		   -> ${PN%-bin}-${PV}-x86_64-unknown-linux-musl.tar.gz )
	arm64? ( https://github.com/zellij-org/zellij/releases/download/v${PV}/${PN%-bin}-aarch64-unknown-linux-musl.tar.gz
		   -> ${PN%-bin}-${PV}-aarch64-unknown-linux-musl.tar.gz )
"

S="${WORKDIR}"

LICENSE="MIT"
# Dependent crate licenses
LICENSE+="
	0BSD Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD CC0-1.0 ISC MIT
	MPL-2.0 Unicode-3.0 ZLIB
"
SLOT="0"
KEYWORDS="-* ~amd64 ~arm64"

RDEPEND="
	!!app-misc/zellij
"

RESTRICT="strip"

QA_PREBUILT="usr/bin/${PN%-bin}"

src_compile() {
	einfo "Generating shell completion files"
	for sh in bash zsh fish; do
		./${PN%-bin} setup --generate-completion $sh > ${PN%-bin}.$sh || die
	done
}

src_install() {
	dobin ${PN%-bin}

	newbashcomp zellij.bash zellij
	newfishcomp zellij.fish zellij.fish
	newzshcomp zellij.zsh _zellij
}
