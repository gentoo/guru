# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

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
BDEPEND="app-arch/unzip"

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

waydroid_version() {
	echo "18.1"
	#use android-11 && echo "18.1" || \
	#use android-13 && echo "20.0" || \
	#die "Unknown version"
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
	local arch="${1}"
	local system_channel="https://ota.waydro.id/system"
	local rom_type="lineage"
	local version="${2:-18.1}"
	local system_type="${3}"
	local system_ota="${system_channel}/${rom_type}/waydroid_${arch}/${system_type}.json"
	local system_file="${WAYDROID_STORE_DIR}/system_${rom_type}_${version}_${system_type}_${arch}.json"

	waydroid_ota_info "${system_ota}" "${system_file}"
}

waydroid_ota_info_vendor() {
	local arch="${1}"
	local vendor_channel="https://ota.waydro.id/vendor"
	local version="${2:-18.1}"
	local vendor_type="${3}"
	local vendor_ota="${vendor_channel}/waydroid_${arch}/${vendor_type}.json"
	local vendor_file="${WAYDROID_STORE_DIR}/vendor_${version}_${vendor_type}_${arch}.json"

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
	for gentoo_arch in amd64 arm arm64 x86; do
		local arch="$(waydroid_arch "${gentoo_arch}")"
		printf "\n\t%s? (" "${gentoo_arch}"

		declare -a ota_info
		readarray -d '' ota_info < <(waydroid_ota_info_system "${arch}" 18.1 VANILLA)
		printf "\n\t\tsystem-vanilla? ( %s -> %s )" "${ota_info[2]}" "${ota_info[0]}"
		readarray -d '' ota_info < <(waydroid_ota_info_system "${arch}" 18.1 GAPPS)
		printf "\n\t\tsystem-gapps? ( %s -> %s )" "${ota_info[2]}" "${ota_info[0]}"
		readarray -d '' ota_info < <(waydroid_ota_info_vendor "${arch}" 18.1 MAINLINE)
		printf "\n\t\tvendor-mainline? ( %s -> %s )" "${ota_info[2]}" "${ota_info[0]}"
		readarray -d '' ota_info < <(waydroid_ota_info_vendor "${arch}" 18.1 HALIUM_11)
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

	local arch="$(waydroid_arch)"
	local version="$(waydroid_version)"
	MY_A=()
	use system-vanilla && waydroid_download_system "${arch}" "${version}" VANILLA
	use system-gapps && waydroid_download_system "${arch}" "${version}" GAPPS
	use vendor-mainline && waydroid_download_vendor "${arch}" "${version}" MAINLINE
	use vendor-halium && waydroid_download_vendor "${arch}" "${version}" HALIUM_11
	unpack "${MY_A[@]}"
}
fi

src_install() {
	insinto /usr/share/waydroid-extra/images
	doins system.img vendor.img
}
