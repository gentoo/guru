# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-mod-r1 toolchain-funcs

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
	declare -A FIRMWARES=(
		[1502_00/npu.sbin.1.5.5.391]=npu.dev.sbin
		[17f1_10/npu.sbin.1.1.0.206]=npu.dev.sbin
		[17f1_10/cert.sbin.1.0.0.28]=cert.dev.sbin
		[17f2_10/npu.sbin.1.1.0.206]=npu.dev.sbin
		[17f2_10/cert.sbin.1.0.0.28]=cert.dev.sbin
		[17f0_10/1.7_npu.sbin.1.1.2.64]=npu.dev.sbin
		[17f0_11/1.7_npu.sbin.1.1.2.65]=npu.dev.sbin
	)

	FW_URI_PREFIX=https://gitlab.com/kernel-firmware/drm-firmware/-/raw/${FW_COMMIT}/amdnpu

	SRC_URI+=" firmware? ( "
	for fw in "${!FIRMWARES[@]}"; do
		SRC_URI+="${FW_URI_PREFIX}/${fw} -> ${FW_COMMIT:0:6}-${fw%%/*}__${FIRMWARES[${fw}]} "
	done
	SRC_URI+=")"
fi

S="${WORKDIR}/${P}/src/driver/amdxdna"
LICENSE="GPL-2 firmware? ( linux-fw-redistributable )"
SLOT="0"
IUSE="+firmware"

pkg_info() {
	if [[ ${PV} != 999999 ]] ; then
		local INFO_FILE="https://raw.githubusercontent.com/amd/xdna-driver/${PV}/tools/info.json"
		local COMMON_PREFIX=https://gitlab.com/kernel-firmware/drm-firmware/-/raw/amd-ipu-staging/amdnpu/
		# shellcheck disable=SC2016
		local JQ_EXPR='.firmwares[] | (.url | sub($prefix; "")) as $p | "    [" + $p + "]=" + .fw_name'

		echo 'declare -A FIRMWARES=('
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

	# Forward clang compiler, otherwise fails when kernel is compiled with clang cflags
	# shellcheck disable=SC2016
	sed -e 's/make -s /make -s CC="${CC}" /' \
		-e 's:>/dev/null 2>&1::' \
		-i "${WORKDIR}/${P}"/src/driver/tools/configure_kernel.sh || die

	default
}

src_configure() {
	cd "${WORKDIR}/${P}/src" || die
	KERNEL_SRC="${KERNEL_DIR}" ARCH=$(tc-arch-kernel) \
	./driver/tools/configure_kernel.sh || die
}

src_compile() {
	local modlist=( amdxdna )
	local modargs=( KERNEL_VER="${KV_FULL}" )

	linux-mod-r1_src_compile
}

src_install() {
	insinto /lib/firmware/amdnpu
	doins -r "${WORKDIR}/${P}/amdxdna_bins/firmware"/*

	insinto /usr/lib/modules-load.d
	newins - amdxdna.conf <<-EOF
		amdxdna
	EOF

	insinto /etc/modprobe.d
	newins - amdxdna.conf <<-EOF
		install amdxdna /sbin/insmod /lib/modules/\$(uname -r)/extra/amdxdna.ko \$CMDLINE_OPTS
	EOF

	linux-mod-r1_src_install
}
