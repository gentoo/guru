# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LLVM_COMPAT=( {17..21} )
PYTHON_COMPAT=( python3_{12..15} )
inherit llvm-r2 python-single-r1 unpacker

DESCRIPTION="A high-level, general-purpose, multi-paradigm, compiled programming language"
HOMEPAGE="https://www.swift.org"
SWIFT_PF="swift-5.10.1-r6" # "${PF/-bin/}" if revisions match
SRC_URI="https://github.com/itaiferber/gentoo-distfiles/releases/download/${CATEGORY}/${SWIFT_PF}/${SWIFT_PF}.gpkg.tar"
S="${WORKDIR}"

LICENSE="Apache-2.0 GPL-2"
SLOT="5/10"
KEYWORDS="-* ~amd64"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RESTRICT="strip"

RDEPEND="
	${PYTHON_DEPS}
	!dev-lang/swift:5
	!~dev-lang/swift-5.10.1:0
	>=app-arch/zstd-1.5
	>=app-eselect/eselect-swift-1.0-r1
	>=dev-db/sqlite-3
	>=dev-libs/icu-69:=
	>=dev-libs/libedit-20221030
	>=dev-libs/libxml2-2.11.5
	>=net-misc/curl-8.4
	>=sys-libs/ncurses-6
	>=virtual/zlib-1.3:=
	dev-lang/python
	$(llvm_gen_dep 'llvm-core/lld:${LLVM_SLOT}=')
"

BDEPEND=">=dev-util/patchelf-0.18"

QA_PREBUILT="*"
PKG_PREINST_SWIFT_INTENTIONALLY_SET='true'

src_unpack() {
	unpack_gpkg "${SWIFT_PF}.gpkg.tar"
}

src_install() {
	[[ -d "${SWIFT_PF}/image" ]] || die "Expected image directory not found in package"

	# Swift 5.10's Foundation and related utils link against ICU libs directly
	# (`libicudata`, `libicui18n`, `libicuuc`), and these libs are explicitly
	# versioned on target systems. We need to fix up the SONAME references to
	# what's actually on the target system.
	#
	# Note: while replacing versioned SONAME references (e.g.,
	# 'libicudata.so.78') with unversioned references (e.g. 'libicudata.so')
	# will work at runtime, this produces QA warnings; we'll replace both
	# versioned and unversioned references with what's installed.
	declare -A iculibs

	# We need extended globbing for '+()' pattern replacement matches below.
	trap "$(shopt -p extglob)" RETURN
	shopt -s extglob

	# For every ELF that depends on any `libicu*` library, we can iterate over
	# every libicu dep and replace it with a reference to the actual SONAME
	# found on disk. `iculibs` stores canonicalized unversioned lib name ->
	# actual SONAME.
	local elfile
	while read -r elfile; do
		# Tab-separated explicitly with `scanelf -F` below. `needed` is a
		# comma-separated list of SONAMEs.
		IFS=$'\t' read -r path needed <<< "${elfile}"
		for lib in ${needed//,/ }; do
			case "${lib}" in
				libicu*)
					# Drop all trailing `.\d+` groups if present so, e.g.,
					# 'libicudata.so', 'libicudata.so.78', and
					# 'libicudata.so.78.3' all canonicalize to 'libicudata.so'.
					local unversioned="${lib%%+(.+([[:digit:]]))}"
					if [[ -z "${iculibs[${unversioned}]}" ]]; then
						local versioned
						versioned="$(readelf -d "/usr/$(get_libdir)/${unversioned}" | \
							awk '/SONAME/{print $NF}' | tr -d '[]')" \
							|| die "Failed to get versioned SONAME for '${unversioned}'"
						iculibs["${unversioned}"]="${versioned}"
					fi

					patchelf --replace-needed "${lib}" "${iculibs[${unversioned}]}" "${SWIFT_PF}${path}" \
						|| die "Failed to replace '${lib}' dependency for '${path}'"
					;;
				*) ;;
			esac
		done
	done < <(scanelf -Rn -F $'%p\t%n' "${SWIFT_PF/image/usr}" | grep libicu) \
		|| die "Failed to scan for libicu references"

	cp -R "${SWIFT_PF}/image/usr" "${ED}" || die "Copying prebuilt files failed"
}

pkg_preinst() {
	# After installation, we ideally want the system to have the latest Swift
	# version set -- but if the system already has a Swift version set and it
	# isn't the latest version, that's likely an intentional decision that we
	# don't want to override.
	local current_swift_version="$(eselect swift show | tail -n1 | xargs)"
	local latest_swift_version="$(eselect swift show --latest | tail -n1 | xargs)"
	[[ "${current_swift_version}" == '(unset)' ]] \
		|| [[ "${current_swift_version}" == "${latest_swift_version}" ]] \
		&& PKG_PREINST_SWIFT_INTENTIONALLY_SET='false'
}

pkg_postinst() {
	# If the system doesn't have Swift intentionally set to an older version, we
	# can update to the latest.
	if [[ "${PKG_PREINST_SWIFT_INTENTIONALLY_SET}" == 'false' ]]; then
		eselect swift update
	fi
}

pkg_postrm() {
	# We don't want to leave behind symlinks pointing to this Swift version on
	# removal.
	local current_swift_version="$(eselect swift show | tail -n1 | xargs)"
	if [[ "${current_swift_version}" == "${P}" ]]; then
		eselect swift update
	fi
}
