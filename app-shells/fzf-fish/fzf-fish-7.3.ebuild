# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Augment your fish command line with fzf key bindings"
HOMEPAGE="https://github.com/PatrickF1/fzf.fish"
SRC_URI="https://github.com/PatrickF1/fzf.fish/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN/-/.}-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

RDEPEND="
	app-shells/fish
	app-shells/fzf
	sys-apps/bat
	sys-apps/fd
"
DEPEND="
	${RDEPEND}
	test? (
		app-shells/clownfish
		app-shells/fishtape
		app-shells/fzf-fish
		dev-vcs/git
	)
"

DOCS=( README.md )
#RESTRICT="!test? ( test )"
RESTRICT="test" # how to run tests?

src_install() {
	insinto "/usr/share/fish/vendor_completions.d"
	doins completions/*
	insinto "/usr/share/fish/vendor_conf.d"
	doins conf.d/*
	insinto "/usr/share/fish/vendor_functions.d"
	doins functions/*
	einstalldocs
}

src_test() {
	# it want a git repo
	git init || die
	git config --global user.email "you@example.com" || die
	git config --global user.name "Your Name" || die
	git add . || die
	git commit -m 'init' || die

	fish -c 'fishtape tests/*/*.fish' || die
}
