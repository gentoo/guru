# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson vala

COMMIT="1b28752e6697cd83408259b18e3158375ff3c025"
LIBPG_COMMIT="9b21e3295402a0d0ee9a50c468d426c2dbb73ee6"
DESCRIPTION="Thin wrapper around libpg_query to use with vala"
HOMEPAGE="https://github.com/ppvan/pg_query_vala"
SRC_URI="
	https://github.com/ppvan/pg_query_vala/archive/${COMMIT}.tar.gz -> ${P}.gh.tar.gz
	https://github.com/pganalyze/libpg_query/archive/${LIBPG_COMMIT}.tar.gz -> ${P}.tar.gz
"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-db/libpg_query
"
DEPEND="${RDEPEND}"
BDEPEND="
	>=dev-libs/glib-2.0.0:2
	dev-db/libpg_query
	dev-lang/vala
	dev-libs/protobuf-c:0/1.0.0
	dev-libs/xxhash
"

PATCHES=(
	# https://github.com/ppvan/pg_query_vala/pull/2
	"${FILESDIR}/unbundle_libpg_query.patch"
)

src_prepare() {
	default
	vala_setup

	rmdir "${S}"/libpg_query || die
	mv "${WORKDIR}"/libpg_query-"${LIBPG_COMMIT}" "${S}"/libpg_query || die
}
