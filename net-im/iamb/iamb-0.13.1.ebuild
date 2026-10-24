# Copyright 2023-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

RUST_MIN_VER="1.96.0"

inherit cargo desktop shell-completion xdg

DESCRIPTION="A Matrix chat client that uses Vim keybindings"
HOMEPAGE="https://iamb.chat/"
SRC_URI="https://github.com/ulyssa/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
DEPS_URI="https://github.com/gentoo-crate-dist/${PN}/releases/download/v${PV}/${P}-crates.tar.xz"
SRC_URI+=" ${DEPS_URI}"

LICENSE="Apache-2.0"
# Dependent crate licenses
LICENSE+="
	Apache-2.0 BSD-2 BSD Boost-1.0 CC0-1.0 CDLA-Permissive-2.0 ISC MIT
	MPL-2.0 MPL-2.0 UoI-NCSA Unicode-3.0 ZLIB
"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-libs/openssl:0
	dev-db/sqlite:3
"

QA_FLAGS_IGNORED="usr/bin/${PN}"

src_configure () {
	export LIBSQLITE3_SYS_USE_PKG_CONFIG=1
	export OPENSSL_NO_VENDOR=1

	local myfeatures=( desktop )
	cargo_src_configure --no-default-features
}

src_install() {
	doman docs/iamb.1
	doman docs/iamb.5

	docinto examples
	dodoc "${S}/config.example.toml"
	docompress -x "/usr/share/doc/${PF}/examples"

	# Generate and install completions
	IAMB_BIN="$(cargo_target_dir)/${PN}"
	mkdir completions || die
	for shell in bash fish zsh; do
		"${IAMB_BIN}" --completions ${shell} > "completions/${PN}.${shell}" || die
	done
	newbashcomp "completions/${PN}.bash" ${PN}
	dofishcomp "completions/${PN}.fish"
	newzshcomp "completions/${PN}.zsh" "_${PN}"

	doicon -s scalable docs/iamb.svg
	domenu iamb.desktop

	insinto /usr/share/metainfo
	doins docs/iamb.metainfo.xml

	cargo_src_install
}
