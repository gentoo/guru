# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-mod-r1 multiprocessing optfeature toolchain-funcs

DESCRIPTION="AMD XDNA Driver"
HOMEPAGE="https://github.com/amd/xdna-driver"

if [[ ${PV} == 999999 ]] ; then
	EGIT_REPO_URI="https://github.com/amd/xdna-driver.git"
	EGIT_SUBMODULES=()
	inherit git-r3

	BDEPEND="
		app-misc/jq
		net-misc/wget
	"
else
	SRC_URI="https://github.com/amd/xdna-driver/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"

	# For live ebuild firmware is fetched from amd-ipu-staging branch of https://gitlab.com/kernel-firmware/drm-firmware.
	# For release commit, see https://github.com/amd/xdna-driver/issues/1236
	# (requires manual date-based commit selection)
	FW_COMMIT=9c532be0fe8d6ac30e8a5e1c0b54a88ae94f50b6

	# To regenerate, run:
	# ebuild xdna-driver-<version>.ebuild info
	declare -Ag FIRMWARES=(
		[1502_00/npu.sbin.1.5.5.391]=npu.dev.sbin
		[17f0_00/npu.sbin.0.7.22.185]=npu.dev.sbin
		[17f0_10/1.7_npu.sbin.1.1.2.64]=npu.dev.sbin
		[17f0_11/1.7_npu.sbin.1.1.2.65]=npu.dev.sbin
	)

	FW_URI_PREFIX=https://gitlab.com/kernel-firmware/drm-firmware/-/raw/${FW_COMMIT}/amdnpu

	SRC_URI+=" "
	for fw in "${!FIRMWARES[@]}"; do
		SRC_URI+="${FW_URI_PREFIX}/${fw} -> ${FW_COMMIT:0:6}-${fw%%/*}__${FIRMWARES[${fw}]} "
	done
fi

S="${WORKDIR}/${P}/src/driver/amdxdna"
LICENSE="GPL-2 linux-fw-redistributable"
SLOT="0"
# Re-use compress-* USE flags from sys-kernel/linux-firmware.
IUSE="compress-xz compress-zstd"
REQUIRED_USE="?? ( compress-xz compress-zstd )"

BDEPEND="
	compress-xz? ( app-arch/xz-utils )
	compress-zstd? ( app-arch/zstd )
"

pkg_setup() {
	if use compress-xz || use compress-zstd ; then
		local CONFIG_CHECK

		if kernel_is -ge 5 19; then
			use compress-xz && CONFIG_CHECK="~FW_LOADER_COMPRESS_XZ"
			use compress-zstd && CONFIG_CHECK="~FW_LOADER_COMPRESS_ZSTD"
		else
			use compress-xz && CONFIG_CHECK="~FW_LOADER_COMPRESS"
			if use compress-zstd; then
				eerror "Kernels <5.19 do not support ZSTD-compressed firmware files"
			fi
		fi
		linux-info_pkg_setup
	fi
	linux-mod-r1_pkg_setup
}

pkg_info() {
	if [[ ${PV} != 999999 ]] ; then
		local INFO_FILE="https://raw.githubusercontent.com/amd/xdna-driver/${PV}/tools/info.json"
		local COMMON_PREFIX=https://gitlab.com/kernel-firmware/drm-firmware/-/raw/amd-ipu-staging/amdnpu/
		# shellcheck disable=SC2016
		local JQ_EXPR='.firmwares[] | (.url | sub($prefix; "")) as $p | "    [" + $p + "]=" + .fw_name'

		echo 'declare -Ag FIRMWARES=('
		curl -s "$INFO_FILE" | jq -r --arg prefix "$COMMON_PREFIX" "$JQ_EXPR"
		echo ')'
	fi
}

src_unpack() {
	local firmware_dir="${WORKDIR}/${P}/amdxdna_bins/firmware"

	if [[ ${PV} == 999999 ]] ; then
		git-r3_src_unpack

		while IFS=$'\t' read -r device pci_dev_id pci_rev_id fw_name url; do
			outdir="${firmware_dir}/${pci_dev_id}_${pci_rev_id}"
			mkdir -p "${outdir}" || die
			wget -O "${outdir}/${fw_name}" "${url}" || die
		done < <(
			jq -r '.firmwares[] |
				[.device, .pci_device_id, .pci_revision_id, .fw_name, .url]
				| @tsv' "${WORKDIR}/${P}/tools/info.json" || die
		) || die
	else
		default

		mkdir -p "${firmware_dir}" || die
		for fw in "${!FIRMWARES[@]}"; do
			local dir="${fw%%/*}"
			local src_filename="${FW_COMMIT:0:6}-${dir}__${FIRMWARES[${fw}]}"
			mkdir -p "${firmware_dir}/${dir}" || die
			cp "${DISTDIR}/${src_filename}" "${firmware_dir}/${dir}/${FIRMWARES[${fw}]}" || die
		done
	fi
}

src_prepare() {
	sed -e "s/-Werror//" -i Kbuild || die

	pushd "${WORKDIR}/${P}" || die
	eapply "${FILESDIR}/${PN}-2.21.75-llvm-support.patch"
	eapply "${FILESDIR}/${PN}-2.21.75-try-compile-config.patch"
	popd || die

	default
}

src_configure() {
	cd "${WORKDIR}/${P}/src" || die
	KERNEL_SRC="${KERNEL_DIR}" \
	KERNEL_VER="${KV_FULL}" \
	ARCH="$(tc-arch-kernel)" \
	CC="${KERNEL_CC}" ./driver/tools/configure_kernel.sh || die
}

src_compile() {
	local modlist=( amdxdna )
	local modargs=( KERNEL_VER="${KV_FULL}" )

	linux-mod-r1_src_compile
}

src_install() {
	insinto /lib/firmware/amdnpu
	doins -r "${WORKDIR}/${P}/amdxdna_bins/firmware"/*

	if use compress-xz || use compress-zstd; then
		pushd "${ED}/lib/firmware/amdnpu" &>/dev/null || die
		einfo "Compressing firmware ..."
		local compressor

		if use compress-xz; then
			compressor="xz -T1 -C crc32"
		elif use compress-zstd; then
			compressor="zstd -15 -T1 -C -q --rm"
		fi
		# shellcheck disable=SC2086
		find . -type f -print0 | \
			xargs -0 -P $(makeopts_jobs) -I'{}' ${compressor} '{}'
		assert
		popd &>/dev/null || die
	fi

	insinto /usr/lib/modules-load.d
	newins - amdxdna.conf <<-EOF
		amdxdna
	EOF

	insinto /etc/modprobe.d
	newins - amdxdna.conf <<-EOF
		install amdxdna /sbin/insmod /lib/modules/\$(uname -r)/extra/amdxdna.ko* \$CMDLINE_OPTS
	EOF

	linux-mod-r1_src_install
}

pkg_postinst() {
	linux-mod-r1_pkg_postinst

	einfo "To reload kernel module between out-of-tree builds run:"
	einfo "modprobe -r amdxdna && modprobe amdxdna"
	einfo "However, switching between in-tree and out-of-tree builds requires a reboot."
	optfeature "for runtime and xrt-smi tool" dev-libs/xrt-xdna
}
