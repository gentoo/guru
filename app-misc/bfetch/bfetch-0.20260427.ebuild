# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="Ultra-fast system fetch tool written in C"
HOMEPAGE="https://github.com/Mjoyufull/bfetch"
COMMIT="831d8a80c3c6f76efaf77f2267007678186d0e85"
SRC_URI="https://github.com/Mjoyufull/bfetch/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/bfetch-${COMMIT}"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64"

src_prepare() {
	default
	sed -i \
		-e 's|$(CC) $(AGGRESSIVE_FLAGS) -o $(TARGET) $(SOURCE)|$(CC) $(CFLAGS) $(LDFLAGS) -o $(TARGET) $(SOURCE)|' \
		Makefile || die "Failed to fix compile line"

	# Remove any forced '-s' or strip command entirely, just in case.
	sed -i 's/-s //g; s/\bstrip\b/true/g' Makefile || die "Failed to remove stripping"
}

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}"
}

src_install() {
	dobin bfetch
	dodoc README.md
}
