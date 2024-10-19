# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Run a command at a particular time"
HOMEPAGE="https://github.com/leahneukirchen/snooze"

inherit git-r3
EGIT_REPO_URI="https://github.com/leahneukirchen/snooze.git"

LICENSE="CC0-1.0"
SLOT="0"

src_compile() {
	emake CFLAGS="${CFLAGS}"
}

src_install() {
	emake DESTDIR="${D}" PREFIX="${EPREFIX}"/usr install
	dodoc {README,NEWS}.md
}
