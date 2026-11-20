# Copyright 2023-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	bindgen@0.72.1
	rust-librocksdb-sys@0.39.0+10.5.1
	rust-rocksdb@0.43.0
	rustc-hash@2.1.1
"

declare -A GIT_CRATES=(
	[ruma-appservice-api]='https://github.com/ruma/ruma;d879f7df16ba9928a73649f8149dabeee939691e;ruma-%commit%/crates/ruma-appservice-api'
	[ruma-client-api]='https://github.com/ruma/ruma;d879f7df16ba9928a73649f8149dabeee939691e;ruma-%commit%/crates/ruma-client-api'
	[ruma-common]='https://github.com/ruma/ruma;d879f7df16ba9928a73649f8149dabeee939691e;ruma-%commit%/crates/ruma-common'
	[ruma-events]='https://github.com/ruma/ruma;d879f7df16ba9928a73649f8149dabeee939691e;ruma-%commit%/crates/ruma-events'
	[ruma-federation-api]='https://github.com/ruma/ruma;d879f7df16ba9928a73649f8149dabeee939691e;ruma-%commit%/crates/ruma-federation-api'
	[ruma-identifiers-validation]='https://github.com/ruma/ruma;d879f7df16ba9928a73649f8149dabeee939691e;ruma-%commit%/crates/ruma-identifiers-validation'
	[ruma-macros]='https://github.com/ruma/ruma;d879f7df16ba9928a73649f8149dabeee939691e;ruma-%commit%/crates/ruma-macros'
	[ruma-push-gateway-api]='https://github.com/ruma/ruma;d879f7df16ba9928a73649f8149dabeee939691e;ruma-%commit%/crates/ruma-push-gateway-api'
	[ruma-signatures]='https://github.com/ruma/ruma;d879f7df16ba9928a73649f8149dabeee939691e;ruma-%commit%/crates/ruma-signatures'
	[ruma-state-res]='https://github.com/ruma/ruma;d879f7df16ba9928a73649f8149dabeee939691e;ruma-%commit%/crates/ruma-state-res'
	[ruma]='https://github.com/ruma/ruma;d879f7df16ba9928a73649f8149dabeee939691e;ruma-%commit%/crates/ruma'
)

LLVM_COMPAT=( {20..23} )
RUST_MIN_VER="1.88.0"

inherit cargo llvm-r2 systemd

MY_P="${PN}-v${PV}"
DESCRIPTION="Matrix homeserver written in Rust"
HOMEPAGE="
	https://conduit.rs
	https://gitlab.com/famedly/conduit
"
SRC_URI="https://gitlab.com/famedly/${PN}/-/archive/v${PV}/${MY_P}.tar.bz2
	https://github.com/sysrq-crate-dist/${PN}/releases/download/v${PV}/${P}-crates.tar.xz
	${CARGO_CRATE_URIS}
"
S="${WORKDIR}/${MY_P}"

LICENSE="Apache-2.0"
# Dependent crate licenses
LICENSE+="
	Apache-2.0 BSD-2 BSD ISC MIT MPL-2.0 openssl Unicode-3.0 ZLIB
"
SLOT="0"
KEYWORDS="~amd64"
IUSE="jemalloc rocksdb sqlite system-rocksdb"

# Libraries that can't be unbundled right now:
#	- app-arch/bzip2 ("rust-librocksdb-sys" pulls "bzip-sys[static]")
#	- app-arch/lz4 ("lz4-sys" crate doesn't look for system library... ironic)
#	- virtual/zlib:= ("rust-librocksdb-sys" pulls "libz-sys[static]")
COMMON_DEPEND="
	jemalloc? ( dev-libs/jemalloc:= )
	rocksdb? (
		app-arch/snappy:=
		app-arch/zstd:=
		system-rocksdb? (
			dev-libs/rocksdb
		)
	)
	sqlite? ( dev-db/sqlite:3 )
"
RDEPEND="${COMMON_DEPEND}
	acct-user/conduit
	app-misc/ca-certificates
"
# libclang needed for bindgen
DEPEND="${COMMON_DEPEND}
	rocksdb? (
		$(llvm_gen_dep '
			llvm-core/clang:${LLVM_SLOT}
			llvm-core/llvm:${LLVM_SLOT}
		')
	)
"
BDEPEND="virtual/pkgconfig"

DOCS=( {APPSERVICES,CODE_OF_CONDUCT,DEPLOY,README,TURN}.md )

PATCHES=(
	"${FILESDIR}"/conduit-0.15.0-update-rocksdb.patch
)

QA_FLAGS_IGNORED="usr/bin/${PN}"

pkg_setup() {
	use rocksdb && llvm-r2_pkg_setup
	rust_pkg_setup
}

src_configure() {
	# * Tracker bug for "*-sys" crates that build C code:
	# https://bugs.gentoo.org/709568
	# * Gentoo Wiki articles with tips and tricks:
	# https://wiki.gentoo.org/wiki/Project:Rust/sys_crates
	# https://wiki.gentoo.org/wiki/Writing_Rust_ebuilds#Unbundling_C_libraries
	export PKG_CONFIG_ALLOW_CROSS=1
	export LIBSQLITE3_SYS_USE_PKG_CONFIG=1
	export ZSTD_SYS_USE_PKG_CONFIG=1
	export SNAPPY_LIB_DIR="${ESYSROOT}/usr/$(get_libdir)"
	export JEMALLOC_OVERRIDE="${ESYSROOT}/usr/$(get_libdir)/libjemalloc.so"

	if use system-rocksdb; then
		export ROCKSDB_INCLUDE_DIR="${ESYSROOT}/usr/include"
		export ROCKSDB_LIB_DIR="${ESYSROOT}/usr/$(get_libdir)"
	fi

	local myfeatures=(
		conduit_bin
		systemd
		$(usev jemalloc)

		# database backends
		$(usex sqlite backend_sqlite '')
		$(usex rocksdb backend_rocksdb '')
	)

	cargo_src_configure --no-default-features
}

src_install() {
	dobin "$(cargo_target_dir)"/conduit

	keepdir /var/lib/matrix-conduit
	fowners conduit:conduit /var/lib/matrix-conduit
	fperms 750 /var/lib/matrix-conduit

	insinto /etc/conduit
	newins conduit-example.toml conduit.toml

	insinto /etc/logrotate.d
	newins "${FILESDIR}"/conduit.logrotate conduit

	newinitd "${FILESDIR}"/conduit.initd-r1 conduit
	newconfd "${FILESDIR}"/conduit.confd conduit
	systemd_newunit "${FILESDIR}"/conduit.service-r1 conduit.service
}
