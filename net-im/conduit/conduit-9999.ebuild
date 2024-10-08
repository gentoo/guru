# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Auto-Generated by cargo-ebuild 0.5.4

EAPI=8

inherit cargo git-r3 systemd toolchain-funcs

DESCRIPTION="Matrix homeserver written in Rust"
HOMEPAGE="
	https://conduit.rs
	https://gitlab.com/famedly/conduit
"
EGIT_REPO_URI="https://gitlab.com/famedly/${PN}"
EGIT_BRANCH="next"

LICENSE="Apache-2.0"
# Dependent crate licenses
LICENSE+="
	|| ( 0BSD Apache-2.0 MIT )
	|| ( Apache-2.0 Apache-2.0-with-LLVM-exceptions MIT )
	|| ( Apache-2.0 BSD MIT )
	|| ( Apache-2.0 BSD-1 MIT )
	|| ( Apache-2.0 BSD-2 MIT )
	|| ( Apache-2.0 Boost-1.0 )
	|| ( Apache-2.0 CC0-1.0 MIT )
	|| ( Apache-2.0 ISC MIT )
	|| ( Apache-2.0 MIT )
	|| ( Apache-2.0 MIT ZLIB )
	|| ( MIT Unlicense )
	BSD BSD-2 ISC MIT MPL-2.0 Unicode-DFS-2016 ZLIB openssl
"
SLOT="0"
IUSE="jemalloc rocksdb system-rocksdb"

# Libraries that can't be unbundled right now:
#	- app-arch/bzip2 (no pkg-config file)
#	- app-arch/lz4 ("lz4-sys" crate doesn't look for system library... ironic)
#	- dev-db/sqlite:3 ("conduit" pulls "rusqlite[bundled]" explicitly)
#	- sys-libs/zlib ("rust-librocksdb-sys" pulls "libz-sys[static]" by default)
DEPEND="
	jemalloc? ( dev-libs/jemalloc:= )
	rocksdb? (
		app-arch/snappy:=
		app-arch/zstd:=
		system-rocksdb? ( dev-libs/rocksdb )
	)
"
RDEPEND="${DEPEND}
	acct-user/conduit
	app-misc/ca-certificates
"
BDEPEND="
	>=virtual/rust-1.75.0
	rocksdb? (
		sys-devel/clang
		virtual/pkgconfig
	)
"

DOCS=( {APPSERVICES,CODE_OF_CONDUCT,DEPLOY,README,TURN}.md )

QA_FLAGS_IGNORED="usr/bin/${PN}"

src_unpack() {
	git-r3_src_unpack
	cargo_live_src_unpack
}

src_configure() {
	tc-export AR CC

	# Tracker bug for that Cargo nonsense:
	# https://bugs.gentoo.org/709568
	export PKG_CONFIG_ALLOW_CROSS=1
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
		backend_persy
		backend_sqlite
		$(usex rocksdb backend_rocksdb '')
	)

	cargo_src_configure --no-default-features --frozen
}

src_install() {
	cargo_src_install

	keepdir /var/lib/matrix-conduit
	fowners conduit:conduit /var/lib/matrix-conduit
	fperms 700 /var/lib/matrix-conduit

	insinto /etc/conduit
	newins conduit-example.toml conduit.toml

	newinitd "${FILESDIR}"/conduit.initd conduit
	newconfd "${FILESDIR}"/conduit.confd conduit
	systemd_dounit "${FILESDIR}"/conduit.service
}