# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# @ECLASS: dotnet-utils.eclass
# @MAINTAINER:
# anna@navirc.com
# @AUTHOR:
# Anna Figueiredo Gomes <anna@navirc.com>
# @SUPPORTED_EAPIS: 7 8
# @BLURB: common functions and variables for dotnet builds

case ${EAPI} in
	7|8) ;;
	*) die "${ECLASS}: EAPI ${EAPI} unsupported." ;;
esac

if [[ ! ${_DOTNET_UTILS_ECLASS} ]]; then
_DOTNET_UTILS_ECLASS=1

inherit edo multiprocessing

# @ECLASS_VARIABLE: DOTNET_SLOT
# @REQUIRED
# @PRE_INHERIT
# @DESCRIPTION:
# Allows to choose a slot for dotnet

if [[ ! ${DOTNET_SLOT} ]]; then
	die "${ECLASS}: DOTNET_SLOT not set"
fi

# Temporary, use the virtual once you can have multiple virtuals installed at once
BDEPEND+=" || ( dev-dotnet/dotnet-sdk-bin:${DOTNET_SLOT} dev-dotnet/dotnet-sdk:${DOTNET_SLOT} )"

# @ECLASS_VARIABLE: DOTNET_EXECUTABLE
# @DEFAULT_UNSET
# @DESCRIPTION:
# Sets the right executable name.

# @ECLASS_VARIABLE: DOTNET_CLI_TELEMETRY_OPTOUT
# @OUTPUT_VARIABLE
# @DESCRIPTION:
# Disables telemetry on dotnet.
export DOTNET_CLI_TELEMETRY_OPTOUT=1

# @ECLASS_VARIABLE: MSBUILDDISABLENODEREUSE
# @OUTPUT_VARIABLE
# @DESCRIPTION:
# Stops the dotnet node after the build is done.
export MSBUILDDISABLENODEREUSE=1

# @ECLASS_VARIABLE: DOTNET_NOLOGO
# @OUTPUT_VARIABLE
# @DESCRIPTION:
# Disables the header logo when running dotnet commands.
export DOTNET_NOLOGO=1

# Needed otherwise the binaries break
RESTRICT+=" strip"

# @ECLASS_VARIABLE: NUGETS
# @DEFAULT_UNSET
# @DESCRIPTION:
# String containing all nuget packages that need to be downloaded.  Used by
# the 'nuget_uris' function.
#
# Example:
# @CODE
# NUGETS="
# 	ImGui.NET-1.87.2
# 	Config.Net-4.19.0
# "
#
# inherit dotnet-utils
#
# ...
#
# SRC_URI="$(nuget_uris)"
# @CODE

# @FUNCTION: nuget_uris
# @USAGE: <nuget...>
# @DESCRIPTION:
# Generates the URIs to put in SRC_URI to help fetch dependencies.
# If no arguments provided, uses NUGETS variable.
nuget_uris() {
	local -r regex='^([a-zA-Z0-9_.-]+)-([0-9]+\.[0-9]+\.[0-9]+.*)$'
	local nuget nugets

	if (( $# != 0 )); then
		nugets="${@}"
	elif [[ ${NUGETS} ]]; then
		nugets="${NUGETS}"
	else
		eerror "NUGETS variable is not defined and nothing passed as argument"
		die "${FUNCNAME}: Can't generate SRC_URI from empty input"
	fi

	for nuget in ${nugets}; do
		local name version url
		[[ ${nuget} =~ ${regex} ]] || die "Could not parse name and version from nuget: $nuget"
		name="${BASH_REMATCH[1]}"
		version="${BASH_REMATCH[2]}"
		url="https://api.nuget.org/v3-flatcontainer/${name}/${version}/${name}.${version}.nupkg"
		echo "${url}"
	done
}

# @FUNCTION: dotnet-utils_pkg_setup
# @DESCRIPTION:
# Sets up DOTNET_RUNTIME and DOTNET_EXECUTABLE variables for later use in edotnet.
dotnet-utils_pkg_setup() {
	if use amd64; then
		DOTNET_RUNTIME="linux-x64"
	elif use arm; then
		DOTNET_RUNTIME="linux-arm"
	elif use arm64; then
		DOTNET_RUNTIME="linux-arm64"
	else
		die "Unsupported arch: ${ARCH}"
	fi

	local _dotnet
	for _dotnet in dotnet{,-bin}-${DOTNET_SLOT}; do
		if type ${_dotnet} 1> /dev/null 2>&1; then
			DOTNET_EXECUTABLE=${_dotnet}
			break
		fi
	done
}

# @FUNCTION: edotnet
# @USAGE: <command> [args...]
# @DESCRIPTION:
# Call dotnet, passing the supplied arguments.
edotnet() {
	debug-print-function ${FUNCNAME} "${@}"

	local dotnet_args=(
		--runtime "${DOTNET_RUNTIME}"
		-maxcpucount:$(makeopts_jobs)
	)

	edo "${DOTNET_EXECUTABLE}" "${@}" "${dotnet_args[@]}"
}

# @FUNCTION: dotnet-utils_src_unpack
# @DESCRIPTION:
# Unpacks the package
dotnet-utils_src_unpack() {
	debug-print-function ${FUNCNAME} "${@}"

	local archive
	for archive in ${A}; do
		case "${archive}" in
			*.nupkg)
				;;
			*)
				unpack ${archive}
				;;
		esac
	done
}

# @FUNCTION: dotnet-utils_src_prepare
# @DESCRIPTION:
# Restore the packages using 'dotnet restore'
dotnet-utils_src_prepare() {
	debug-print-function ${FUNCNAME} "${@}"

	edotnet restore --source "${DISTDIR}" || die "'dotnet restore' failed"
	default_src_prepare
}

# @FUNCTION: dotnet-utils_src_compile
# @DESCRIPTION:
# Build the package using dotnet publish
dotnet-utils_src_compile() {
	debug-print-function ${FUNCNAME} "${@}"

	local publish_args=(
		--no-restore
		--configuration Release
		-p:Version=${PV}
		-p:DebugType=embedded
		--self-contained
	)

	edotnet publish "${publish_args[@]}" || die "'dotnet publish' failed"
}

fi

EXPORT_FUNCTIONS pkg_setup src_unpack src_prepare src_compile
