# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES=""
declare -A GIT_CRATES=(
	[syntect]="https://github.com/trishume/syntect;64644ffe064457265cbcee12a0c1baf9485ba6ee;syntect-%commit%"
)

inherit cargo linux-info

DESCRIPTION="Turso Database is an in-process OLTP database engine library with a CLI"
HOMEPAGE="https://github.com/tursodatabase/turso"
SRC_URI="
	https://github.com/tursodatabase/${PN}/releases/download/v${PV}/source.tar.gz -> ${P}.tar.gz
	https://github.com/freijon/${PN}/releases/download/v${PV}/${P}-crates.tar.xz
	${CARGO_CRATE_URIS}
"

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

DEPEND="
	>=dev-libs/libgit2-0.99:=
	dev-libs/oniguruma:=
"
RDEPEND="${DEPEND}"

pkg_setup() {
	CONFIG_CHECK="~IO_URING"
	WARNING_IO_URING="The USE flag 'uring' needs the option IO_URING to be enabled."

	use uring && linux-info_pkg_setup
	rust_pkg_setup
}

src_configure() {
	# high magic to allow system-libs
	export LIBSQLITE3_SYS_USE_PKG_CONFIG=1
	export RUSTONIG_SYSTEM_LIBONIG=1
	export LIBGIT2_NO_VENDOR=1

	local myfeatures=(
		$(use uring && usex "uring" "io_uring")
	)
	cargo_src_configure --no-default-features
}

src_compile() {
	cargo_src_compile --package "${PN}_cli" --bin "tursodb"
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
