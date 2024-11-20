# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson vala

COMMIT="1672a38f04d4c8ba61f0ddc11e1203c824e704e9"
LIBPG_COMMIT="9b21e3295402a0d0ee9a50c468d426c2dbb73ee6"
DESCRIPTION="Thin wrapper around libpg_query to use with vala"
HOMEPAGE="https://github.com/ppvan/pg_query_vala"
SRC_URI="
	https://github.com/ppvan/pg_query_vala/archive/${COMMIT}.tar.gz -> ${P}.gh.tar.gz
"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-db/libpg_query
	dev-libs/glib
"
DEPEND="${RDEPEND}"
BDEPEND="
	>=dev-libs/glib-2.0.0:2
	dev-db/libpg_query
	dev-lang/vala
	dev-libs/protobuf-c:0/1.0.0
	dev-libs/xxhash
"

src_prepare() {
	default
	vala_setup
}
