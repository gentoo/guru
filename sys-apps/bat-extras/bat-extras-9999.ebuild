# Copyright 2022-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Bash scripts that integrate bat with various command line tools."
HOMEPAGE="https://github.com/eth-p/bat-extras"
if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/eth-p/bat-extras.git"
else
	KEYWORDS="~amd64"
	SRC_URI="https://github.com/eth-p/bat-extras/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	# Requires test dir to be a git repo
	RESTRICT="test"
fi

LICENSE="MIT"
SLOT="0"

DEPEND="
	app-shells/bash
	sys-apps/bat
	dev-util/sh
"
RDEPEND="
	${DEPEND}
	app-admin/entr
	app-shells/fzf
	dev-python/black
	dev-util/git-delta
	dev-vcs/git
	sys-apps/eza
	sys-apps/ripgrep
	sys-devel/clang[extra(+)]
	sys-libs/ncurses
	virtual/rust[rustfmt(+)]
"

src_unpack() {
	default
	if [[ ${PV} == *9999 ]]; then
		git-r3_checkout
	fi
}

src_prepare() {
	# remove license
	rm LICENSE.md || die
	# remove contribution document
	rm CONTRIBUTING.md || die
	default
}

src_compile() {
	./build.sh --compress --minify=all --manuals --no-verify || die "build failed"
}

src_test() {
	./test.sh || die "test failed"
}

src_install() {
	dobin bin/*
	doman man/*
}

pkg_postinst() {
	einfo "To enable additional code formatting for 'prettybat' script, ensure"
	einfo "'net-libs/nodejs' is installed in your system, and use 'npm' to install"
	einfo "'prettier' (npm i -g prettier). Once 'prettier' is properly installed in"
	einfo "your system, remerge this package."
}
