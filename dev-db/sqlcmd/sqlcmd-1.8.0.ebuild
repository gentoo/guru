# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module shell-completion

DESCRIPTION="The MSSQL SQLCMD CLI tool"
HOMEPAGE="https://learn.microsoft.com/sql/tools/sqlcmd/go-sqlcmd-utility"
SRC_URI="https://github.com/microsoft/go-${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

# Using a dependency tarball as per https://devmanual.gentoo.org/eclass-reference/go-module.eclass/index.html
DEPS_URI="https://gitlab.com/freijon_gentoo/${CATEGORY}/${PN}/-/raw/main/${P}-deps.tar.xz"
SRC_URI+=" ${DEPS_URI}"

S="${WORKDIR}/go-${P}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

src_compile() {
	ego build -o "${PN}" -ldflags="-X main.version=${PV}" ./cmd/modern
}

src_install() {
	dobin "${PN}"
	mkdir "completions" || die

	./sqlcmd completion bash > "completions/${PN}" || die
	./sqlcmd completion fish > "completions/${PN}.fish" || die
	./sqlcmd completion zsh > "completions/_${PN}" || die
	dobashcomp "completions/${PN}"
	dofishcomp "completions/${PN}.fish"
	dozshcomp "completions/_${PN}"

	local DOCS=(
		"README.md"
		"SECURITY.md"
	)

	einstalldocs
}
