# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES=""

inherit cargo linux-info

DESCRIPTION="The Limbo interactive SQL shell"
HOMEPAGE="https://github.com/tursodatabase/limbo"
SRC_URI="
	https://github.com/tursodatabase/${PN}/releases/download/v${PV}/source.tar.gz -> ${P}.tar.gz
"
DEPS_URI="https://github.com/freijon/${PN}/releases/download/v${PV}/${P}-crates.tar.xz"
SRC_URI+=" ${DEPS_URI}"

S="${WORKDIR}/${PN}_cli-${PV}"

LICENSE="MIT"
# Dependent crate licenses
LICENSE+="
	Apache-2.0 Apache-2.0-with-LLVM-exceptions Boost-1.0 CC0-1.0 CDDL
	GPL-2.0-with-bison-exception MIT MPL-2.0 Unicode-DFS-2016
"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+uring"

pkg_setup() {
	CONFIG_CHECK="~IO_URING"
	WARNING_IO_URING="The USE flag 'uring' needs the option IO_URING to be enabled."

	use uring && linux-info_pkg_setup
	rust_pkg_setup
}

src_configure() {
	local myfeatures=(
		$(use uring && usex "uring" "io_uring")
	)
	cargo_src_configure --no-default-features
}

src_compile() {
	cargo_src_compile --package "${PN}_cli" --bin "${PN}"
}

src_install() {
	cargo_src_install --path cli

	local DOCS=(
		CHANGELOG.md
		CONTRIBUTING.md
		README.md
	)

	einstalldocs
}
