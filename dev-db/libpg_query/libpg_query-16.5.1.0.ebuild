# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PV="${PV/16\./16-}"
DESCRIPTION="C library for accessing the PostgreSQL parser outside of the server environment"
HOMEPAGE="https://github.com/pganalyze/libpg_query"
SRC_URI="https://github.com/pganalyze/libpg_query/archive/${MY_PV}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/${PN}-${MY_PV}"

LICENSE="BSD"
SLOT="0/16"
KEYWORDS="~amd64"
IUSE="examples static-libs"

BDEPEND="
	dev-libs/protobuf-c
	dev-libs/xxhash
"

src_prepare() {
	default

	if ! use static-libs; then
		sed -i -e "s/^install: \$(ARLIB) \$(SOLIB)$/install: \$(SOLIB)/" "${S}"/Makefile || die
		sed -i -e "/^	\$(INSTALL) -m 644 \$(ARLIB) \"\$(DESTDIR)\"\$(libdir)\/\$(ARLIB)$/d" "${S}"/Makefile || die
	fi
}

src_compile() {
	emake build_shared
	use static-libs && emake build
	use examples && emake examples
}

src_test() {
	emake test
}

src_install() {
	emake \
		prefix="${ED}"/usr \
		libdir="${ED}/usr/$(get_libdir)" \
		install
}
