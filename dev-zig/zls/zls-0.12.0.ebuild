# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit edo

DESCRIPTION="The officially unofficial Ziglang language server"
HOMEPAGE="https://github.com/zigtools/zls"

SRC_URI="
	https://github.com/zigtools/zls/archive/refs/tags/${PV}.tar.gz -> zls-${PV}.tar.gz
	https://codeberg.org/BratishkaErik/distfiles/releases/download/zls-${PV}/zls-${PV}-deps.tar.xz
	https://codeberg.org/BratishkaErik/distfiles/releases/download/zls-${PV}/zls-${PV}-version_data.tar.xz
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

EZIG_MIN="0.12"
EZIG_MAX_EXCLUSIVE="0.13"

DEPEND="|| ( dev-lang/zig:${EZIG_MIN} dev-lang/zig-bin:${EZIG_MIN} )"
RDEPEND="${DEPEND}"

# see https://github.com/ziglang/zig/issues/3382
# For now, Zig Build System doesn't support CFLAGS/LDFLAGS/etc.
QA_FLAGS_IGNORED="usr/bin/zls"

# : copied from sys-fs/ncdu :
# Many thanks to Florian Schmaus (Flowdalic)!
# Adapted from https://github.com/gentoo/gentoo/pull/28986
# Set the EZIG environment variable.
zig-set_EZIG() {
	[[ -n ${EZIG} ]] && return

	if [[ -n ${EZIG_OVERWRITE} ]]; then
		export EZIG="${EZIG_OVERWRITE}"
		return
	fi

	local candidates candidate selected selected_ver

	candidates=$(compgen -c zig-)

	for candidate in ${candidates}; do
		if [[ ! ${candidate} =~ zig(-bin)?-([.0-9]+) ]]; then
			continue
		fi

		local ver
		if (( ${#BASH_REMATCH[@]} == 3 )); then
			ver="${BASH_REMATCH[2]}"
		else
			ver="${BASH_REMATCH[1]}"
		fi

		if [[ -n ${EZIG_EXACT_VER} ]]; then
			ver_test "${ver}" -ne "${EZIG_EXACT_VER}" && continue

			selected="${candidate}"
			selected_ver="${ver}"
			break
		fi

		if [[ -n ${EZIG_MIN} ]] \
			   && ver_test "${ver}" -lt "${EZIG_MIN}"; then
			# Candidate does not satisfy EZIG_MIN condition.
			continue
		fi

		if [[ -n ${EZIG_MAX_EXCLUSIVE} ]] \
			   && ver_test "${ver}" -ge "${EZIG_MAX_EXCLUSIVE}"; then
			# Candidate does not satisfy EZIG_MAX_EXCLUSIVE condition.
			continue
		fi

		if [[ -n ${selected_ver} ]] \
			   && ver_test "${selected_ver}" -gt "${ver}"; then
			# Candidate is older than the currently selected candidate.
			continue
		fi

		selected="${candidate}"
		selected_ver="${ver}"
	done

	if [[ -z ${selected} ]]; then
		die "Could not find (suitable) zig installation in PATH"
	fi

	export EZIG="${selected}"
	export EZIG_VER="${ver}"
}

# Invoke zig with the optionally provided arguments.
ezig() {
	zig-set_EZIG

	# Unfortunately, we cannot add more args here, since syntax is different
	# for every subcommands. Yes, even target/cpu :( f.i. :
	# -target/-mcpu for zig build-exe vs -Dtarget/-Dcpu for zig build-
	# -OReleaseSafe for zig build-exe vs -DReleaseSafe for zig build
	# (or even none, if hardcoded by upstream so choice is -Drelease=true/false)
	# Ofc we can patch this, but still...

	edo "${EZIG}" "${@}"
}

src_configure() {
	export ZBS_ARGS=(
		--prefix usr/
		-Doptimize=ReleaseSafe
		--system "${WORKDIR}/zig-eclass/p/"
		-Dversion_data_file_path=version_data.zig
		--verbose
	)
}

src_compile() {
	ezig build "${ZBS_ARGS[@]}" || die
}

src_test() {
	ezig build test "${ZBS_ARGS[@]}" || die
}

src_install() {
	DESTDIR="${ED}" ezig build install "${ZBS_ARGS[@]}" || die
	dodoc README.md
}

pkg_postinst() {
	elog "You can find more information about options here: https://github.com/zigtools/zls/wiki/Configuration"
}
