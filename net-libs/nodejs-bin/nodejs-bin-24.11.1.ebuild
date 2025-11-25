# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A JavaScript runtime built on Chrome's V8 JavaScript engine"
HOMEPAGE="https://nodejs.org/"
SRC_URI="
	amd64? ( https://nodejs.org/dist/v${PV}/node-v${PV}-linux-x64.tar.xz )
"
S="${WORKDIR}/node-v${PV}-linux-x64" #only works for amd64 now

LICENSE="Apache-1.1 Apache-2.0 BSD BSD-2 MIT Artistic-2"
SLOT="0"
KEYWORDS="-* ~amd64"

IUSE="corepack +npm"

COMMON_DEPEND="
	!net-libs/nodejs
	>=app-arch/brotli-1.1.0:=
	dev-db/sqlite:3
	>=dev-libs/libuv-1.51.0:=
	>=dev-libs/simdjson-4.0.7:=
	>=net-dns/c-ares-1.34.5:=
	>=net-libs/nghttp2-1.66.0:=
	>=net-libs/nghttp3-1.7.0:=
	virtual/zlib:=
	corepack? ( !sys-apps/yarn )
"
DEPEND="${COMMON_DEPEND}"
RDEPEND="${COMMON_DEPEND}"

src_install() {
	dodoc *.md
	dodoc ./share/doc/node/*
	doman ./share/man/man1/*

	local base="$(pwd)"
	local dest="/opt/${P}"

	insinto "$dest"
	doins -r ./include/ ./lib/

	exeinto "$dest/bin"
	doexe ./bin/node

	insinto "$dest/bin"
	doins ./bin/npx
	[[ npm ]] && doins ./bin/npm
	[[ corepack ]] && doins ./bin/corepack

	# Find all executable file but not symlink, make them executable at destination
	local rel
	while IFS= read -r file; do
		rel=${file#${base}/}
		[[ -f "${D}/${dest}/${rel}" ]] && fperms +x "${dest}/${rel}"
	done < <(find ./include ./bin ./lib -type f -perm /111 ! -xtype l)

	# Make symlinks
	for exe in "${dest}"/bin/*; do
		dosym "${exe}" "/usr/bin/$(basename "$exe")"
	done
}
