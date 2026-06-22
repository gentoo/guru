# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="Unconventional package manager that compiles & installs packages from git repos"
HOMEPAGE="https://git.symlinx.net/pkgit"

EGIT_REPO_URI="https://git.symlinx.net/pkgit"
EGIT_TAG="${PV}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-lang/luajit:="
DEPEND="${RDEPEND}
	dev-build/make"

src_compile() {
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" PREFIX="${EPREFIX}/usr" install || die "install failed"
}
