# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit shell-completion

DESCRIPTION="Fast all-in-one JavaScript runtime, bundler, transpiler, and package manager"
HOMEPAGE="https://bun.com/ https://github.com/oven-sh/bun/"

SRC_URI="
	amd64? ( https://github.com/oven-sh/bun/releases/download/bun-v${PV}/bun-linux-x64.zip -> ${P}-amd64.zip )
	arm64? ( https://github.com/oven-sh/bun/releases/download/bun-v${PV}/bun-linux-aarch64.zip -> ${P}-arm64.zip )
"

S="${WORKDIR}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64"
RESTRICT="strip test"

BDEPEND="app-arch/unzip"

QA_PREBUILT="usr/bin/bun"

src_prepare() {
	default

	local bun_dir
	if use amd64; then
		bun_dir="bun-linux-x64"
	elif use arm64; then
		bun_dir="bun-linux-aarch64"
	else
		die "Unsupported architecture"
	fi

	mv "${bun_dir}"/bun . || die "Bun binary not found in ${WORKDIR}/${bun_dir}"
}

src_compile() {
	local shell
	for shell in bash fish zsh; do
		# set PATH to skip InstallCompletionsCommand::install_bunx_symlink() which causes sandbox violation
		PATH=. SHELL=${shell} ./bun completions > bun.${shell} || die
	done
}

src_install() {
	dobin bun
	dosym bun /usr/bin/bunx

	einstalldocs

	newbashcomp bun.bash bun
	newfishcomp bun.fish bun.fish
	newzshcomp bun.zsh _bun
}
