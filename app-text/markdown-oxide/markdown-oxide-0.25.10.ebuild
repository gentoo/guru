# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cargo

DESCRIPTION="PKM Markdown Language Server"
HOMEPAGE="https://github.com/Feel-ix-343/markdown-oxide"
SRC_URI="
	https://github.com/Feel-ix-343/markdown-oxide/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://gitlab.com/api/v4/projects/69517529/packages/generic/${PN}/${PV}/${P}-deps.tar.xz
"

LICENSE="0BSD Apache-2.0 BSD CC0-1.0 ISC MIT MPL-2.0 Unicode-3.0"
SLOT="0"
KEYWORDS="~amd64"

src_unpack() {
	cargo_src_unpack

	ln -s "${ECARGO_VENDOR}/tower-lsp-macros" "${ECARGO_VENDOR}/tower-lsp"

	cat >> "${ECARGO_HOME}/config.toml" <<- EOF || die
		[patch."https://github.com/Feel-ix-343/tower-lsp"]
		tower-lsp = { path = "${ECARGO_VENDOR}/tower-lsp" }
	EOF
}

src_install() {
	cargo_src_install --frozen
}
