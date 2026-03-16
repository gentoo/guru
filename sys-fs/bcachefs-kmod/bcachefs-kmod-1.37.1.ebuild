# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MODULES_INITRAMFS_IUSE=+initramfs

inherit linux-mod-r1 unpacker verify-sig

MY_PN="bcachefs-tools"

DESCRIPTION="Linux bcachefs kernel module for sys-fs/bcachefs-tools"
HOMEPAGE="https://bcachefs.org/"
if [[ ${PV} == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://evilpiepirate.org/git/bcachefs-tools.git"
else
	SRC_URI="https://evilpiepirate.org/bcachefs-tools/bcachefs-tools-${PV}.tar.zst"
	SRC_URI+=" verify-sig? ( https://evilpiepirate.org/bcachefs-tools/bcachefs-tools-${PV}.tar.sign )"
	KEYWORDS="~amd64 ~arm64"
	S="${WORKDIR}/${MY_PN}-${PV}"
fi

LICENSE="GPL-2"
SLOT="0"

IUSE="debug verify-sig"

MODULES_KERNEL_MIN=6.16

VERIFY_SIG_OPENPGP_KEY_PATH=/usr/share/openpgp-keys/kentoverstreet.asc

BDEPEND="
	>=sys-kernel/linux-headers-6.16
	verify-sig? ( >=sec-keys/openpgp-keys-kentoverstreet-20241012 )
"

pkg_setup() {
	# See https://github.com/koverstreet/bcachefs-tools/blob/master/libbcachefs/Kconfig
	local CONFIG_CHECK="
		BLOCK
		EXPORTFS
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

	# Live builds will overwrite .version with git-describe output
	echo "${PV}" > .version || die
	emake DESTDIR="${WORKDIR}" PREFIX="/module" install_dkms
}

src_compile() {
	local dirs=( "${WORKDIR}/module/src/${PN%-*}-"* )
	local module_src="${dirs[0]}"

	[[ -d "${module_src}" ]] || die

	local modlist=( "bcachefs=:${module_src}:${module_src}/src/fs/bcachefs" )
	local modargs=(
		KDIR=${KV_OUT_DIR}
	)

	linux-mod-r1_src_compile
}
