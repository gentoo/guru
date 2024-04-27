# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Forked from : https://github.com/gentoo-mirror/pg_overlay/blob/master/dev-libs/qrcodegen

EAPI=8

DESCRIPTION="High-quality QR Code generator library"
HOMEPAGE="https://www.nayuki.io/page/qr-code-generator-library"
SRC_URI="https://github.com/nayuki/QR-Code-generator/archive/v${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/QR-Code-generator-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

PATCHES=(
	"${FILESDIR}/c_makefile_generate_libraries.patch"
	"${FILESDIR}/cpp_makefile_generate_libraries.patch"
)

src_prepare() {
	default
	sed '/^C\(XX\)\?FLAGS/s/-O//' -i {c,cpp}/Makefile || die
}

src_compile() {
	for dir in c cpp
	do
		emake -C ${dir}
	done
}

src_install() {
	local -x DESTDIR="${ED}"
	for dir in c cpp
	do
		emake -C ${dir} install-header
		emake -C ${dir} LIBDIR="${ED}"/usr/$(get_libdir) VERSION=${PV} install-shared
	done
}
