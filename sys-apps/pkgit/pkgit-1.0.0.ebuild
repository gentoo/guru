# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Unconventional package manager that compiles & installs packages from git repos"
HOMEPAGE="https://git.symlinx.net/pkgit"
SRC_URI="https://codeberg.org/RealFCC/pkgit/archive/${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}"
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
