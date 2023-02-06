# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

EGIT_REPO_URI="https://github.com/zigtools/zls"

HOMEPAGE="https://github.com/zigtools/zls"
DESCRIPTION="The officially unofficial Ziglang language server"

LICENSE="MIT"
SLOT="0"

DEPEND="~dev-lang/zig-9999"
RDEPEND="${DEPEND}"

# see https://github.com/ziglang/zig/issues/3382
# For now, Zig Build System doesn't support CFLAGS/LDFLAGS/etc.
QA_FLAGS_IGNORED="usr/bin/zls"

src_compile() {
	zig build -Doptimize=ReleaseSafe -Ddata_version=master --verbose || die
}

src_test() {
	zig build test -Doptimize=ReleaseSafe -Ddata_version=master --verbose || die
}

src_install() {
	DESTDIR="${ED}" zig build install --prefix /usr -Doptimize=ReleaseSafe -Ddata_version=master --verbose || die
	dodoc README.md
}

pkg_postinst() {
	elog "You can find more information about options here https://github.com/zigtools/zls#configuration-options"
}
