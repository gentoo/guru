# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit flag-o-matic git-r3 toolchain-funcs

DESCRIPTION="A faster implementation of i3lock-fancy"
HOMEPAGE="https://github.com/yvbbrjdr/i3lock-fancy-rapid"
EGIT_REPO_URI="https://github.com/yvbbrjdr/i3lock-fancy-rapid.git"

LICENSE="BSD"
SLOT="0"

RDEPEND="
	|| (
		>=x11-misc/i3lock-2.12
		>=x11-misc/i3lock-color-2.12
	)
"
DEPEND="x11-libs/libX11"

src_prepare() {
	default
	sed -e "s/gcc/$(tc-getCC)/" \
		-e "/CFLAGS=/d" \
		-i Makefile || die
}

src_configure() {
	default
	append-cflags -fopenmp -lX11
}

src_install() {
	dobin i3lock-fancy-rapid
	einstalldocs
}
