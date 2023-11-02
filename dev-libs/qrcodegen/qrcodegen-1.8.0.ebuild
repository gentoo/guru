# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Forked from : https://github.com/gentoo-mirror/pg_overlay/blob/master/dev-libs/qrcodegen

EAPI=8

DESCRIPTION="High-quality QR Code generator library"
HOMEPAGE="https://www.nayuki.io/page/qr-code-generator-library"
SRC_URI="https://github.com/nayuki/QR-Code-generator/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="${RDEPEND}
	${PYTHON_DEPS}"

S=${WORKDIR}/QR-Code-generator-${PV}

PATCHES=( "${FILESDIR}/c_makefile_generate_libraries.patch" )
PATCHES+=( "${FILESDIR}/cpp_makefile_generate_libraries.patch" )

src_compile() {
	pushd c
	emake
	popd

	pushd cpp
	emake
	popd
}

src_install() {
	pushd c
	emake DESTDIR="${D}" install-header
	emake DESTDIR="${D}" LIBDIR="${D}"/usr/$(get_libdir) install-shared
	popd

	pushd cpp
	emake DESTDIR="${D}" install-header
	emake DESTDIR="${D}" LIBDIR="${D}"/usr/$(get_libdir) install-shared
	popd
}
