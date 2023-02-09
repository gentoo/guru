# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

HOMEPAGE="https://github.com/zigtools/zls"
DESCRIPTION="The officially unofficial Ziglang language server"

KNOWN_FOLDERS_COMMIT="24845b0103e611c108d6bc334231c464e699742c"
TRACY_COMMIT="f493d4aa8ba8141d9680473fad007d8a6348628e"
SRC_URI="
	https://github.com/ziglibs/known-folders/archive/${KNOWN_FOLDERS_COMMIT}.tar.gz -> known-folders-${KNOWN_FOLDERS_COMMIT}.tar.gz
	https://github.com/wolfpld/tracy/archive/${TRACY_COMMIT}.tar.gz -> tracy-${TRACY_COMMIT}.tar.gz
	https://github.com/zigtools/zls/archive/refs/tags/${PV}.tar.gz -> zls-${PV}.tar.gz
"
KEYWORDS="~amd64"

LICENSE="MIT"
SLOT="0"

DEPEND="|| ( ~dev-lang/zig-0.10.1 ~dev-lang/zig-bin-0.10.1 )"
RDEPEND="${DEPEND}"

# see https://github.com/ziglang/zig/issues/3382
# For now, Zig Build System doesn't support CFLAGS/LDFLAGS/etc.
QA_FLAGS_IGNORED="usr/bin/zls"

PATCHES=(
	"${FILESDIR}/zls-0.10.0-add-builtin-data-for-new-zig-versions.patch"
)

src_prepare() {
	rm -r src/known-folders || die
	mv "../known-folders-${KNOWN_FOLDERS_COMMIT}" src/known-folders || die
	rm -r src/tracy || die
	mv "../tracy-${TRACY_COMMIT}" src/zinput || die

	default
}

src_compile() {
	zig build -Drelease-safe -Ddata_version=0.10.0 --verbose || die
}

src_test() {
	zig build test -Drelease-safe -Ddata_version=0.10.0 --verbose || die
}

src_install() {
	DESTDIR="${ED}" zig build install --prefix /usr -Drelease-safe -Ddata_version=0.10.0 --verbose || die
	dodoc README.md
}

pkg_postinst() {
	elog "You can find more information about options here https://github.com/zigtools/zls#configuration-options"
}
