# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..9} )

inherit distutils-r1 toolchain-funcs

DESCRIPTION="The Wren Programming Language"
HOMEPAGE="https://wren.io/"
SRC_URI="
	https://github.com/wren-lang/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/wren-lang/${PN}-cli/archive/${PV}.tar.gz -> ${PN}-cli-${PV}.tar.gz
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-libs/libuv"
DEPEND="${RDEPEND}"

src_prepare() {
	default

	# Don't pre-strip
	sed -i 's/-s$//' projects/make/wren_shared.make || die
	sed -i 's/-s$//' "${WORKDIR}"/wren-cli-${PV}/projects/make/wren_cli.make || die

	cat <<EOF > ${PN}.pc
prefix="${EPREFIX}/usr"
libdir="\${prefix}/$(get_libdir)"
includedir="\${prefix}/include"

Name: ${PN}
Description: ${DESCRIPTION}
URL: ${HOMEPAGE}
Version: ${PV}
Libs: "-L\${libdir}" -l${PN}
Cflags: "-I\${includedir}"
EOF
}

src_compile() {
	tc-export CC
	cd projects/make
	emake verbose=1
	cd "${WORKDIR}/wren-cli-${PV}/projects/make"
	emake verbose=1
}

python_test() {
	${EPYTHON} util/test.py || die
}

src_install() {
	newbin "${WORKDIR}"/wren-cli-${PV}/bin/wren_cli wren
	dolib.so lib/libwren.so
	doheader src/include/wren.h
	doheader src/include/wren.hpp

	insinto /usr/$(get_libdir)/pkgconfig
	doins ${PN}.pc
	einstalldocs
}
