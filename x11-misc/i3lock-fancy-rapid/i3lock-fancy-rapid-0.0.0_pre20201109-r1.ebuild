# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit flag-o-matic toolchain-funcs

MY_REV="c70ecfa8a529cb71f21f475f31d748ce9b154a8b"

DESCRIPTION="A faster implementation of i3lock-fancy"
HOMEPAGE="https://github.com/yvbbrjdr/i3lock-fancy-rapid"
SRC_URI="https://github.com/yvbbrjdr/i3lock-fancy-rapid/archive/${MY_REV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${MY_REV}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

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
		-e 's/$(CC) $^ $(CFLAGS) -o $@/$(CC) $^ $(CFLAGS) $(LDFLAGS) -o $@/' \
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
