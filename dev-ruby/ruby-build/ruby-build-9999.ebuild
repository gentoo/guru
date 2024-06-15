# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="Installs virtually any version of Ruby, from source"
HOMEPAGE="https://github.com/rbenv/ruby-build"
LICENSE="MIT"

SLOT=0
EGIT_REPO_URI="https://github.com/rbenv/ruby-build.git"
EGIT_BRANCH=master

src_compile() {
	:
}

src_install() {
	dobin bin/ruby-build
	exeinto /usr/libexec/rbenv
	doexe bin/rbenv-install
	doexe bin/rbenv-uninstall
	insinto /usr/share/ruby-build
	doins share/ruby-build/*
	doman share/man/man1/*.1
	dodoc README.md
}
