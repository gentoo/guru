# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MODULES_KERNEL_MIN=6.16
MODULES_INITRAMFS_IUSE=+initramfs
MY_PN="bcachefs-tools"
MODULE_S="module/src/${PN%-*}-${PV}"
VERIFY_SIG_OPENPGP_KEY_PATH=/usr/share/openpgp-keys/kentoverstreet.asc

inherit flag-o-matic linux-mod-r1 toolchain-funcs unpacker verify-sig

DESCRIPTION="Linux bcachefs kernel module for sys-fs/bcachefs-tools"
HOMEPAGE="https://bcachefs.org/"
if [[ ${PV} == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://evilpiepirate.org/git/bcachefs-tools.git"
else
	SRC_URI="https://evilpiepirate.org/bcachefs-tools/bcachefs-tools-${PV}.tar.zst"
	SRC_URI+=" verify-sig? ( https://evilpiepirate.org/bcachefs-tools/bcachefs-tools-${PV}.tar.sign )"
	S="${WORKDIR}/${P}"
	KEYWORDS="~amd64 ~arm64"
fi

S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="GPL-2"
# Dependent crate licenses
LICENSE+=" Apache-2.0 BSD ISC MIT Unicode-DFS-2016"
SLOT="0"

IUSE="debug verify-sig"

DEPEND="~sys-fs/bcachefs-tools-${PV}"

RDEPEND="${DEPEND}
"

BDEPEND=">=sys-kernel/linux-headers-6.16
	verify-sig? ( >=sec-keys/openpgp-keys-kentoverstreet-20241012 )
"
pkg_setup() {
	local CONFIG_CHECK="
		BLOCK
		CRC_OPTIMIZATIONS
		EXPORTFS
		CLOSURES
		CRC32
		CRC64
		FS_POSIX_ACL
		LZ4_COMPRESS
		LZ4_DECOMPRESS
		LZ4HC_COMPRESS
		ZLIB_DEFLATE
		ZLIB_INFLATE
		ZSTD_COMPRESS
		ZSTD_DECOMPRESS
		CRYPTO_LIB_SHA256
		CRYPTO_LIB_CHACHA
		CRYPTO_LIB_POLY1305
		KEYS
		RAID6_PQ
		XOR_BLOCKS
		XXHASH
		SYMBOLIC_ERRNAME
		MIN_HEAP
		XARRAY_MULTI
	"
	use amd64 && CONFIG_CHECK+="
		CRYPTO_CHACHA20_X86_64
		CRYPTO_POLY1305_X86_64
	"
	use debug && CONFIG_CHECK+="
		DEBUG_INFO
		FRAME_POINTER
		!DEBUG_INFO_REDUCED
	"
	linux-mod-r1_pkg_setup
}

src_unpack() {
	# Upstream signs the uncompressed tarball
	if use verify-sig; then
		einfo "Unpacking ${P}.tar.zst ..."
		verify-sig_verify_detached - "${DISTDIR}"/${MY_PN}-${PV}.tar.sign \
			< <(zstd -fdc "${DISTDIR}"/${MY_PN}-${PV}.tar.zst | tee >(tar -xf -))
		assert "Unpack failed"
	fi

	if [[ ${PV} == "9999" ]]; then
		git-r3_src_unpack
	else
		unpacker ${MY_PN}-${PV}.tar.zst
	fi

}

src_prepare() {
	default
	tc-export CC

	sed -i s/^VERSION=.*$/VERSION=${PV}/ Makefile || die
	sed \
		-e '/^CFLAGS/s:-O2::' \
		-e '/^CFLAGS/s:-g::' \
		-i Makefile || die
	append-lfs-flags

	emake DESTDIR="${WORKDIR}" PREFIX="/module" install_dkms
	sed -i "s|^#define TRACE_INCLUDE_PATH .*|#define TRACE_INCLUDE_PATH ${WORKDIR}/${MODULE_S}/src/fs/bcachefs|" \
		../${MODULE_S}/src/fs/bcachefs/trace.h || die
	sed -i '/mean_and_variance_test.o/Id' ../${MODULE_S}/src/fs/bcachefs/Makefile|| die
}

src_compile() {
	local modlist=( "bcachefs=kernel/fs/bcachefs:../${MODULE_S}:../${MODULE_S}/src/fs/bcachefs" )
	local modargs=(
		KDIR=${KV_OUT_DIR}
	)

	linux-mod-r1_src_compile
}

src_install() {
	linux-mod-r1_src_install
}

pkg_postinst() {
	linux-mod-r1_pkg_postinst
}
