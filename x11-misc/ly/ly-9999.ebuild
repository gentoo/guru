# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit edo pam systemd git-r3 prefix

DESCRIPTION="Ly - a TUI display manager (live ebuild)"
HOMEPAGE="https://github.com/fairyglade/ly"

EGIT_REPO_URI="https://github.com/fairyglade/ly.git"

LICENSE="WTFPL-2"
SLOT="0"

# Specify the required Zig version range
EZIG_MIN="0.13"
EZIG_MAX_EXCLUSIVE="0.14"

DEPEND="
	|| ( dev-lang/zig-bin:${EZIG_MIN} dev-lang/zig:${EZIG_MIN} )
	sys-libs/pam
	x11-libs/libxcb
"
RDEPEND="
	x11-base/xorg-server
	x11-apps/xauth
	sys-libs/ncurses
	x11-apps/xrdb
"

# Ignore QA warnings about missing build-id for Zig binaries
# https://github.com/ziglang/zig/issues/3382
QA_FLAGS_IGNORED="usr/bin/ly"

RES="${S}/res"

# Function to dynamically fetch dependency versions from build.zig.zon
fetch_deps_dynamically() {
	local build_zig_zon="${S}/build.zig.zon"
	local content

	if [[ ! -f "${build_zig_zon}" ]]; then
		eerror "build.zig.zon not found at ${build_zig_zon}"
		return 1
	fi

	content=$(<"${build_zig_zon}")

	# Extract CLAP version
	if [[ "${content}" =~ clap.*?refs/tags/([0-9]+\.[0-9]+\.[0-9]+) ]]; then
		CLAP="refs/tags/${BASH_REMATCH[1]}"
	else
		eerror "Failed to extract CLAP version"
		return 1
	fi

	# Extract ZIGINI commit hash
	if [[ "${content}" =~ zigini.*?/([a-f0-9]{40})\.tar\.gz ]]; then
		ZIGINI="${BASH_REMATCH[1]}"
	else
		eerror "Failed to extract ZIGINI commit hash"
		return 1
	fi

	einfo "Extracted CLAP version: ${CLAP}"
	einfo "Extracted ZIGINI commit: ${ZIGINI}"
}

# Function to fetch nested dependency versions
fetch_nested_deps_dynamically() {
	local root_build_zig_zon="${S}/build.zig.zon"
	local root_content
	local zigini_hash
	local nested_build_zig_zon
	local nested_content

	# Read the root build.zig.zon
	root_content=$(<"${root_build_zig_zon}")

	# Extract the hash for the zigini dependency
	if [[ "${root_content}" =~ zigini.*hash[[:space:]]*=[[:space:]]*\"([a-f0-9]+)\" ]]; then
		zigini_hash="${BASH_REMATCH[1]}"
	else
		eerror "Failed to extract zigini hash from root build.zig.zon"
		return 1
	fi

	# Construct the path to the nested build.zig.zon
	nested_build_zig_zon="${WORKDIR}/deps/p/${zigini_hash}/build.zig.zon"

	if [[ ! -f "${nested_build_zig_zon}" ]]; then
		eerror "Nested build.zig.zon not found at ${nested_build_zig_zon}"
		return 1
	fi

	# Read the nested build.zig.zon
	nested_content=$(<"${nested_build_zig_zon}")

	# Extract the ZIGLIBINI value
	if [[ "${nested_content}" =~ ini.*?/([a-f0-9]{40})\.tar\.gz ]]; then
		ZIGLIBINI="${BASH_REMATCH[1]}"
	else
		eerror "Failed to extract ZIGLIBINI commit hash"
		return 1
	fi

	einfo "Extracted ZIGLIBINI commit: ${ZIGLIBINI}"
}

# Function to set the EZIG environment variable
zig-set_EZIG() {
	[[ -n ${EZIG} ]] && return
	if [[ -n ${EZIG_OVERWRITE} ]]; then
		export EZIG="${EZIG_OVERWRITE}"
		return
	fi
	local candidate selected selected_ver ver
	for candidate in "${BROOT}"/usr/bin/zig-*; do
		if [[ ! -L ${candidate} || ${candidate} != */zig?(-bin)-+([0-9.]) ]]; then
			continue
		fi
		ver=${candidate##*-}
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
		die "Could not find (suitable) zig installation in ${BROOT}/usr/bin"
	fi
	export EZIG="${selected}"
	export EZIG_VER="${selected_ver}"
}

# Wrapper function for zig command
ezig() {
	zig-set_EZIG
	edo "${EZIG}" "${@}"
}

# Unpack source and fetch dependencies
src_unpack() {
	git-r3_src_unpack
	# Fetch CLAP and ZIGINI
	fetch_deps_dynamically
	mkdir "${WORKDIR}/deps" || die
	ezig fetch --global-cache-dir "${WORKDIR}/deps" "https://github.com/Hejsil/zig-clap/archive/${CLAP}.tar.gz"
	ezig fetch --global-cache-dir "${WORKDIR}/deps" "https://github.com/Kawaii-Ash/zigini/archive/${ZIGINI}.tar.gz"
	# Fetch ZIGLIBINI
	fetch_nested_deps_dynamically
	ezig fetch --global-cache-dir "${WORKDIR}/deps" "https://github.com/ziglibs/ini/archive/${ZIGLIBINI}.tar.gz"
}


src_prepare(){
	default
	# Adjusting absolute paths in the following files to use Gentoo's ${EPREFIX}
	hprefixify "${RES}/config.ini" "${RES}/setup.sh"
}

src_compile() {
	# Building ly & accomodate for prefixed environment
	ezig build --system "${WORKDIR}/deps/p" -Doptimize=ReleaseSafe
}

# Install the binary and configuration files
src_install() {
	dobin "${S}/zig-out/bin/${PN}"
	newinitd "${RES}/${PN}-openrc" ly
	systemd_dounit "${RES}/${PN}.service"
	insinto /etc/ly
	doins "${RES}/config.ini" "${RES}/setup.sh"
	insinto /etc/ly/lang
	doins "${RES}"/lang/*.ini
	newpamd "${RES}/pam.d/ly" ly
	fperms +x /etc/${PN}/setup.sh
}

# Post-installation messages and warnings
pkg_postinst() {
	systemd_reenable "${PN}.service"
	ewarn
	ewarn "The init scripts are installed only for systemd/openrc"
	ewarn "If you are using something else like runit etc."
	ewarn "Please check upstream for get some help"
	ewarn "You may need to take a look at /etc/ly/config.ini"
	ewarn "If you are using a window manager as DWM"
	ewarn "Please make sure there is a .desktop file in /usr/share/xsessions for it"
	ewarn
	ewarn "This is a live ebuild, which means it will always install the latest commit."
	ewarn "If you encounter any issues, please report them to the upstream project."
}
