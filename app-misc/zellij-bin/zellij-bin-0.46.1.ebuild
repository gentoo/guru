# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop shell-completion toolchain-funcs xdg

BASE_URI="https://github.com/zellij-org/zellij/releases/download"

DESCRIPTION="A terminal workspace with batteries included"
HOMEPAGE="https://zellij.dev/"
SRC_URI="
	amd64? (
		!terminal? ( ${BASE_URI}/v${PV}/${PN%-bin}-x86_64-unknown-linux-musl.tar.gz
			-> ${PN%-bin}-${PV}-x86_64-unknown-linux-musl.tar.gz )

		terminal? ( ${BASE_URI}/v${PV}/${PN%-bin}-x86_64-unknown-linux-gnu.tar.gz
			-> ${PN%-bin}-${PV}-x86_64-unknown-linux-gnu.tar.gz )
	)

	arm64? (
		!terminal? ( ${BASE_URI}/v${PV}/${PN%-bin}-aarch64-unknown-linux-musl.tar.gz
			-> ${PN%-bin}-${PV}-aarch64-unknown-linux-musl.tar.gz )

		terminal? ( ${BASE_URI}/v${PV}/${PN%-bin}-aarch64-unknown-linux-gnu.tar.gz
			-> ${PN%-bin}-${PV}-aarch64-unknown-linux-gnu.tar.gz )
	)
"

S="${WORKDIR}"

LICENSE="MIT"
# Dependent crate licenses
LICENSE+="
	0BSD Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD CC0-1.0 ISC MIT
	MPL-2.0 Unicode-3.0 ZLIB
"
SLOT="0"
KEYWORDS="-* ~amd64"
IUSE="terminal"

RDEPEND="
	!!app-misc/zellij
	terminal? (
		dev-libs/wayland
		media-libs/fontconfig
		media-libs/mesa[wayland]
		x11-libs/libxkbcommon[wayland]
	)
"

RESTRICT="strip"

QA_PREBUILT="opt/bin/${PN%-bin}"

src_compile() {
	if tc-is-cross-compiler; then
		ewarn "Cross-compiling: shell completion not installed."
		ewarn "Generate them on the target with \"${PN%-bin} setup --help\"."

		if use terminal; then
			ewarn "Cross-compiling: desktop entry files not installed."
			ewarn "Generate them on the target with \"${PN%-bin} setup --help\"."
		fi

	else
		if use terminal; then
			einfo "Generating desktop entries"
			./${PN%-bin} setup --install-desktop-entry || die
		fi

		einfo "Generating shell completion files"
		for sh in bash zsh fish; do
			./${PN%-bin} setup --generate-completion ${sh} > ${PN%-bin}.${sh} || die
		done
	fi
}

src_install() {
	into /opt
	dobin ${PN%-bin}

	if use terminal; then
		insinto /usr/share/metainfo
		# this file doesn't get generated with zellij setup
		doins "${FILESDIR}"/dev.zellij.Zellij.metainfo.xml
	fi

	if ! tc-is-cross-compiler; then
		newbashcomp zellij.bash zellij
		newfishcomp zellij.fish zellij.fish
		newzshcomp zellij.zsh _zellij
		if use terminal; then
			domenu "${HOME}"/.local/share/applications/dev.zellij.Zellij.desktop
			for i in 128x128 256x256 512x512; do
				insinto /usr/share/icons/hicolor/${i}/apps
				doins "${HOME}"/.local/share/icons/hicolor/${i}/apps/dev.zellij.Zellij.png
			done
		fi
	fi
}
