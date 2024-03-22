# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..12} )

inherit python-any-r1

DESCRIPTION="Manage images for app-containers/waydroid using portage"
HOMEPAGE="https://sourceforge.net/projects/waydroid/files/images"

if [[ ${PV} == 9999 ]]; then
	PROPERTIES="live"
else
	# Generate using:
	# WAYDROID_GEN_SRC_URI=y ebuild waydroid-images-9999.ebuild clean unpack
	#SRC_URI=""
	KEYWORDS="~amd64 ~arm ~arm64 ~x86"
fi
S="${WORKDIR}"

# https://source.android.com/docs/setup/about/faqs#what-kind-of-open-source-project-is-android
LICENSE="Apache-2.0"

SLOT="0"
IUSE="+system-vanilla system-gapps +vendor-mainline vendor-halium"
REQUIRED_USE="
	^^ ( system-vanilla system-gapps )
	^^ ( vendor-mainline vendor-halium )
"

RDEPEND="app-containers/waydroid"

if [[ ${PV} == 9999 ]]; then
	BDEPEND+="
		net-misc/wget
		${PYTHON_DEPS}
	"
fi

waydroid_arch() {
	case "${1:-${ARCH}}" in
		amd64) echo "x86_64" ;;
		arm) echo "arm" ;;
		arm64) echo "arm64" ;;
		x86) echo "x86" ;;
		*) die "Unsupported architecture"
	esac
}

waydroid_ota_info() {
	local ota_url="${1}"
	local ota_file="${2}"

	[[ ${EVCS_OFFLINE} ]] || wget -q -O "${ota_file}" "${ota_url}" || die
	[[ -f ${ota_file} ]] || die "OTA information unavailable: ${ota_file}"

	cat "${ota_file}" | \
		python3 -c 'import sys,json;j=json.load(sys.stdin)["response"][0];\
		print(*(j[x] for x in ["filename","id","url"]),sep="\0",end="")' || die
}

waydroid_ota_info_system() {
	local system_channel="https://ota.waydro.id/system"
	local rom_type="lineage"
	local system_type="${1}"
	local system_ota="${system_channel}/${rom_type}/waydroid_${MY_ARCH}/${system_type}.json"
	local system_file="${WAYDROID_STORE_DIR}/system_${rom_type}_${system_type}_${MY_ARCH}.json"

	waydroid_ota_info "${system_ota}" "${system_file}"
}

waydroid_ota_info_vendor() {
	local vendor_channel="https://ota.waydro.id/vendor"
	local vendor_type="${1}"
	local vendor_ota="${vendor_channel}/waydroid_${MY_ARCH}/${vendor_type}.json"
	local vendor_file="${WAYDROID_STORE_DIR}/vendor_${vendor_type}_${MY_ARCH}.json"

	waydroid_ota_info "${vendor_ota}" "${vendor_file}"
}

waydroid_download_image() {
	local dl_file="${1}"
	local dl_filename="${2}"
	local dl_hash="${3}"
	local dl_url="${4}"

	local newhash=""
	if [[ -f ${dl_file} ]]; then
		ebegin "${dl_filename} SHA256"
		newhash="$(sha256sum "${dl_file}" 2>/dev/null | cut -f1 -d\ )"
		if [[ ${newhash} == ${dl_hash} ]]; then
			eend 0
			return
		fi
		eend 1
	fi

	if [[ ! ${EVCS_OFFLINE} ]]; then
		wget -O "${dl_file}" "${dl_url}" || die

		ebegin "${dl_filename} SHA256"
		newhash="$(sha256sum "${dl_file}" 2>/dev/null | cut -f1 -d\ )"
		if [[ ${newhash} == ${dl_hash} ]]; then
			eend 0
			return
		fi
		eend 1
	fi

	[[ -f ${dl_file} ]] || die "File not available: ${dl_file}"
	eerror "Expected: ${newhash}"
	eerror "Got: ${dl_hash}"
	die "Checksum mismatch for ${dl_file}"
}

waydroid_download_system() {
	declare -a ota_info
	readarray -d '' ota_info < <(waydroid_ota_info_system "$@")
	local file="${WAYDROID_STORE_DIR}/${ota_info[0]}"
	MY_A+=( "${file}" )
	waydroid_download_image "$file" "${ota_info[@]}"
}

waydroid_download_vendor() {
	declare -a ota_info
	readarray -d '' ota_info < <(waydroid_ota_info_vendor "$@")
	local file="${WAYDROID_STORE_DIR}/${ota_info[0]}"
	MY_A+=( "${file}" )
	waydroid_download_image "${file}" "${ota_info[@]}"
}

waydroid_gen_src_uri() {
	for arch in amd64 arm arm64 x86; do
		MY_ARCH="$(waydroid_arch "${arch}")"
		printf "\n\t%s? (" "${arch}"

		declare -a ota_info
		readarray -d '' ota_info < <(waydroid_ota_info_system VANILLA)
		printf "\n\t\tsystem-vanilla? ( %s -> %s )" "${ota_info[2]}" "${ota_info[0]}"
		readarray -d '' ota_info < <(waydroid_ota_info_system GAPPS)
		printf "\n\t\tsystem-gapps? ( %s -> %s )" "${ota_info[2]}" "${ota_info[0]}"
		readarray -d '' ota_info < <(waydroid_ota_info_vendor MAINLINE)
		printf "\n\t\tvendor-mainline? ( %s -> %s )" "${ota_info[2]}" "${ota_info[0]}"
		readarray -d '' ota_info < <(waydroid_ota_info_vendor HALIUM_11)
		printf "\n\t\tvendor-halium? ( %s -> %s )" "${ota_info[2]}" "${ota_info[0]}"

		printf "\n\t)"
	done
	printf "\n\n"
}

if [[ ${PV} == 9999 ]]; then
src_unpack() {
	local distdir=${PORTAGE_ACTUAL_DISTDIR:-${DISTDIR}}
	: "${WAYDROID_STORE_DIR:=${distdir}/waydroid}"
	if [[ ! -d ${WAYDROID_STORE_DIR} && ! ${EVCS_OFFLINE} ]]; then
		(
			addwrite /
			mkdir -p "${WAYDROID_STORE_DIR}"
		) || die "Unable to create ${WAYDROID_STORE_DIR}"
	fi
	addwrite "${WAYDROID_STORE_DIR}"

	if [[ ${WAYDROID_GEN_SRC_URI} ]]; then
		waydroid_gen_src_uri
		die
	fi

	MY_ARCH="$(waydroid_arch)"
	MY_A=()
	use system-vanilla && waydroid_download_system VANILLA
	use system-gapps && waydroid_download_system GAPPS
	use vendor-mainline && waydroid_download_vendor MAINLINE
	use vendor-halium && waydroid_download_vendor HALIUM_11
	unpack "${MY_A[@]}"
}
fi

src_install() {
	insinto /usr/share/waydroid-extra/images
	doins system.img vendor.img
}
