# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="Run a command at a particular time"
HOMEPAGE="https://github.com/leahneukirchen/snooze"

inherit git-r3
EGIT_REPO_URI="https://github.com/leahneukirchen/snooze.git"

LICENSE="CC0-1.0"
SLOT="0"

src_compile() {
	tc-export CC
	emake CFLAGS="${CFLAGS}"
}

src_install() {
	emake DESTDIR="${D}" PREFIX="${EPREFIX}"/usr install
	dodoc {README,NEWS}.md
}
