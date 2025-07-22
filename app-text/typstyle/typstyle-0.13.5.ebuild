# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES=" "

inherit edo cargo

DESCRIPTION="A beautiful and reliable code formatter for Typst"
HOMEPAGE="https://enter-tainer.github.io/typstyle/"
SRC_URI="https://github.com/Enter-tainer/${PN}/archive/v${PV}/${P}.tar.gz"
SRC_URI+=" https://github.com/ingenarel/guru-depfiles/releases/download/${P}-deps.tar.xz/${P}-deps.tar.xz"
ECARGO_VENDOR="${WORKDIR}/vendor"

LICENSE="Apache-2.0"
# Dependent crate licenses
LICENSE+="
	Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD-2 BSD CC0-1.0 ISC MIT
	MPL-2.0 Unicode-3.0 ZLIB
"
SLOT="0"
KEYWORDS="~amd64 ~arm64"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	app-text/typst
"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-vcs/git
	test? ( dev-util/cargo-nextest )
"

QA_FLAGS_IGNORED="usr/bin/typstyle"

DOCS=( README.md )

src_compile() {
	export VERGEN_GIT_DESCRIBE="v${PV}"
	export VERGEN_GIT_SHA=$(gunzip < "${DISTDIR}/${P}.tar.gz" | git get-tar-commit-id)

	cargo_src_compile
}

src_install() {
	cargo_src_install --path "${S}/crates/${PN}"
	einstalldocs
}

src_test() {
	edo cargo nextest run --workspace -E 'test([typst])' --no-fail-fast --no-default-features
}
