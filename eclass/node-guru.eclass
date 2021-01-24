# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EXPORT_FUNCTIONS src_prepare src_compile src_install

SLOT="0"
IUSE=""
DEPEND="net-libs/nodejs"
RDEPEND="${DEPEND}"
BDEPEND="
	app-misc/jq
	sys-apps/moreutils
"
S="${WORKDIR}"

node-guru_src_prepare() {
	jq 'if .dependencies? then .dependencies[] = "*" else . end' package/package.json | sponge package/package.json || die
	default
}

node-guru_src_compile() {
	return
}

node-guru_src_install() {
	local dir="${ED}/usr/$(get_libdir)/node_modules/"
	mkdir -p "${dir}" || die
	mv package "${dir}/${PN}" || die
}
