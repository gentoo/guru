# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES=""

inherit cargo shell-completion

DESCRIPTION="Friendly and fast tool for sending HTTP requests"
HOMEPAGE="https://github.com/ducaale/xh"
SRC_URI="https://github.com/ducaale/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
DEPS_URI="https://github.com/freijon/${PN}/releases/download/v${PV}/${P}-crates.tar.xz"
SRC_URI+=" ${DEPS_URI}"

LICENSE="MIT"
# Dependent crate licenses
LICENSE+=" Apache-2.0 BSD ISC MIT MPL-2.0 Unicode-DFS-2016"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test"

DEPEND="
	dev-libs/oniguruma:=
	dev-libs/openssl:0=
"
RDEPEND="${DEPEND}"

DOCS=( {CHANGELOG,README}.md )

QA_FLAGS_IGNORED="usr/bin/${PN}"

src_configure() {
	# high magic to allow system-libs
	export OPENSSL_NO_VENDOR=true
	export RUSTONIG_SYSTEM_LIBONIG=1

	myfeatures=(
		native-tls
	)

	cargo_src_configure --no-default-features
}

src_install() {
	cargo_src_install

	# See https://github.com/ducaale/xh#making-https-requests-by-default
	dosym "${PN}" "/usr/bin/${PN}s"

	einstalldocs
	doman "doc/${PN}.1"

	newbashcomp "completions/${PN}.bash" "${PN}"
	dozshcomp "completions/_${PN}"
	dofishcomp "completions/${PN}.fish"
}
