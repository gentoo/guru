# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-mod-r1 toolchain-funcs

# To regenerate, run:
# ebuild xdna-driver-999999.ebuild info
FW_COMMIT=5c040900cb08fe65c4f76c0c63ce5d7f318eae93

declare -A FIRMWARES=(
	[1502_00/npu.sbin.1.5.5.391]=npu.dev.sbin
	[17f1_10/npu.sbin.0.0.20.173]=npu.dev.sbin
	[17f1_10/cert.sbin.20260217]=cert.dev.sbin
	[17f2_10/npu.sbin.0.0.20.173]=npu.dev.sbin
	[17f2_10/cert.sbin.20260217]=cert.dev.sbin
	[17f0_10/npu.sbin.255.0.11.69]=npu.dev.sbin
	[17f0_11/npu.sbin.255.0.11.71]=npu.dev.sbin
)

DESCRIPTION="AMD XDNA Driver"
HOMEPAGE="https://github.com/amd/xdna-driver"

if [[ ${PV} == 999999 ]] ; then
	EGIT_REPO_URI="https://github.com/amd/xdna-driver.git"
	EGIT_SUBMODULES=()
	inherit git-r3
else
	SRC_URI="https://github.com/amd/xdna-driver/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

FW_URI_PREFIX=https://gitlab.com/kernel-firmware/drm-firmware/-/raw/${FW_COMMIT}/amdnpu

SRC_URI+=" firmware? ( "
for fw in "${!FIRMWARES[@]}"; do
	SRC_URI+="${FW_URI_PREFIX}/${fw} -> ${FW_COMMIT:0:6}-${fw%%/*}__${FIRMWARES[${fw}]} "
done
SRC_URI+=")"

S="${WORKDIR}/${P}/src/driver/amdxdna"
LICENSE="GPL-2 firmware? ( linux-fw-redistributable )"
SLOT="0"
IUSE="+firmware"

pkg_info() {
	local FWAPI=https://gitlab.com/api/v4/projects/kernel-firmware%2Fdrm-firmware/repository/branches/amd-ipu-staging
	local FW_COMMIT=$(curl -s "$FWAPI" | jq -r '.commit.id')
	local INFO_FILE=https://raw.githubusercontent.com/amd/xdna-driver/main/tools/info.json
	local COMMON_PREFIX=https://gitlab.com/kernel-firmware/drm-firmware/-/raw/amd-ipu-staging/amdnpu/
	# shellcheck disable=SC2016
	local JQ_EXPR='.firmwares[] | (.url | sub($prefix; "")) as $p | "    [" + $p + "]=" + .fw_name'

	printf "FW_COMMIT=%s\n\n" "$FW_COMMIT"
	echo 'declare -A FIRMWARES=('
	curl -s "$INFO_FILE" | jq -r --arg prefix "$COMMON_PREFIX" "$JQ_EXPR"
	echo ')'
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
	for fw in "${!FIRMWARES[@]}"; do
		local dir="${fw%%/*}"
		local src_filename="${FW_COMMIT:0:6}-${dir}__${FIRMWARES[${fw}]}"
		insinto "/lib/firmware/amdnpu/${dir}"
		newins "${DISTDIR}/${src_filename}" "${FIRMWARES[${fw}]}"
	done

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
