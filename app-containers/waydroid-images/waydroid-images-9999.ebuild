# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

inherit edo python-any-r1

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
IUSE="+system-vanilla system-gapps +vendor-mainline vendor-halium android-10 android-11 +android-13"
REQUIRED_USE="
	^^ ( system-vanilla system-gapps )
	^^ ( vendor-mainline vendor-halium )
	^^ ( android-10 android-11 android-13 )
	vendor-halium? (
		amd64? ( || ( android-11 ) )
		arm? ( || ( android-10 android-11 android-13 ) )
		arm64? ( || ( android-10 android-11 android-13 ) )
		x86? ( || ( android-11 ) )
	)
"

RDEPEND="app-containers/waydroid"
BDEPEND="app-arch/unzip"

if [[ ${PV} == 9999 ]]; then
	BDEPEND+="
		net-misc/wget
		${PYTHON_DEPS}
	"
fi

waydroid_allarches=( amd64 arm arm64 x86 )
waydroid_arch() {
	case "${1:-${ARCH}}" in
		amd64) echo x86_64 ;;
		arm) echo arm ;;
		arm64) echo arm64 ;;
		x86) echo x86 ;;
		*) die "Unsupported architecture"
	esac
}

waydroid_allversions=( android-10 android-11 android-13 )
waydroid_version() {
	local ver="${1:-$(for x in "${waydroid_allversions[@]}"; do usev "${x}"; done)}"
	case "${ver}" in
		android-10) echo 17.1 ;;
		android-11) echo 18.1 ;;
		android-13) echo 20.0 ;;
		*) die "Unknown version"
	esac
}

waydroid_halium() {
	case "${1:-$(waydroid_arch)}-${2:-$(waydroid_version)}" in
		arm-17.1|arm64-17.1) echo HALIUM_10 ;;
		*-18.1) echo HALIUM_11 ;;
		arm-20.0|arm64-20.0) echo HALIUM_13 ;;
	esac
}

waydroid_ota_info() {
	local version="${1}"
	local ota_url="${2}"
	local ota_file="${3}"

	[[ ${EVCS_OFFLINE} ]] || edo wget -q -O "${ota_file}" "${ota_url}"
	[[ -f ${ota_file} ]] || die "OTA information unavailable: ${ota_file}"

	cat "${ota_file}" | \
		python3 -c 'import sys,json;j=json.load(sys.stdin)["response"];\
		j=[x for x in j if x["version"]==sys.argv[1]][0];\
		print(*(j[x] for x in ["filename","id","url"]),sep="\0",end="")' \
		"${version}" || die
}

waydroid_ota_info_system() {
	local arch="${1}"
	local system_channel="https://ota.waydro.id/system"
	local rom_type="lineage"
	local version="${2}"
	local system_type="${3}"
	local system_ota="${system_channel}/${rom_type}/waydroid_${arch}/${system_type}.json"
	local system_file="${WAYDROID_STORE_DIR}/system_${rom_type}_${system_type}_${arch}.json"

	waydroid_ota_info "${version}" "${system_ota}" "${system_file}"
}

waydroid_ota_info_vendor() {
	local arch="${1}"
	local vendor_channel="https://ota.waydro.id/vendor"
	local version="${2}"
	local vendor_type="${3}"
	local vendor_ota="${vendor_channel}/waydroid_${arch}/${vendor_type}.json"
	local vendor_file="${WAYDROID_STORE_DIR}/vendor_${vendor_type}_${arch}.json"

	waydroid_ota_info "${version}" "${vendor_ota}" "${vendor_file}"
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
		edo wget -O "${dl_file}" "${dl_url}"

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
	local t="${T}/src_uri"
	rm -f "${t}"; touch "${t}"
	for gentoo_version in "${waydroid_allversions[@]}"; do
		local version="$(waydroid_version "${gentoo_version}")"
		printf "\n\t%s? (" "${gentoo_version}" >> "${t}"
		for gentoo_arch in "${waydroid_allarches[@]}"; do
			local arch="$(waydroid_arch "${gentoo_arch}")"
			printf "\n\t\t%s? (" "${gentoo_arch}" >> "${t}"
			declare -a ota_info

			readarray -d '' ota_info < \
				<(waydroid_ota_info_system "${arch}" "${version}" VANILLA)
			printf "\n\t\t\tsystem-vanilla? ( %s -> %s )" \
				"${ota_info[2]}" "${ota_info[0]}" >> "${t}"

			readarray -d '' ota_info < \
				<(waydroid_ota_info_system "${arch}" "${version}" GAPPS)
			printf "\n\t\t\tsystem-gapps? ( %s -> %s )" \
				"${ota_info[2]}" "${ota_info[0]}" >> "${t}"

			readarray -d '' ota_info < \
				<(waydroid_ota_info_vendor "${arch}" "${version}" MAINLINE)
			printf "\n\t\t\tvendor-mainline? ( %s -> %s )" \
				"${ota_info[2]}" "${ota_info[0]}" >> "${t}"

			local halium="$(waydroid_halium "${arch}" "${version}")"
			if [[ ${halium} ]]; then
				readarray -d '' ota_info < \
					<(waydroid_ota_info_vendor "${arch}" "${version}" "${halium}")
				printf "\n\t\t\tvendor-halium? ( %s -> %s )" \
					"${ota_info[2]}" "${ota_info[0]}" >> "${t}"
			fi

			printf "\n\t\t)" >> "${t}"
		done
		printf "\n\t)" >> "${t}"
	done
	printf "\n\n" >> "${t}"
	cat "${t}"
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
	local halium="$(waydroid_halium "${arch}" "${version}")"
	MY_A=()
	use system-vanilla && waydroid_download_system "${arch}" "${version}" VANILLA
	use system-gapps && waydroid_download_system "${arch}" "${version}" GAPPS
	use vendor-mainline && waydroid_download_vendor "${arch}" "${version}" MAINLINE
	if use vendor-halium && [[ ! ${halium} ]]; then
		die "USE=vendor-halium is unavailable for the selected version"
	else
		waydroid_download_vendor "${arch}" "${version}" "${halium}"
	fi
	unpack "${MY_A[@]}"
}
fi

src_install() {
	insinto /usr/share/waydroid-extra/images
	doins system.img vendor.img
}
