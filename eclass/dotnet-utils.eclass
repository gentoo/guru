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

inherit multiprocessing

# @ECLASS_VARIABLE: DOTNET_SLOT
# @DESCRIPTION:
# Allows for choosing a slot for dotnet
# @DEFAULT_UNSET

if [[ -z "${DOTNET_SLOT}" ]]; then
	die "DOTNET_SLOT not set."
fi

# Temporary, use the virtual once you can have multiple virtuals installed at once
BDEPEND+=" || ( dev-dotnet/dotnet-sdk:${DOTNET_SLOT} dev-dotnet/dotnet-sdk-bin:${DOTNET_SLOT} )"
EXPORT_FUNCTIONS src_unpack src_prepare src_compile pkg_setup

# @ECLASS_VARIABLE: DOTNET_EXECUTABLE
# @DESCRIPTION:
# Holds the right executable name
# @DEFAULT_UNSET

# @ECLASS_VARIABLE: DOTNET_CLI_TELEMETRY_OPTOUT
# @DESCRIPTION:
# Disables telemetry on dotnet.
export DOTNET_CLI_TELEMETRY_OPTOUT=1
# @ECLASS_VARIABLE: MSBUILDDISABLENODEREUSE
# @DESCRIPTION:
# Stops the dotnet node from not stopping after the build is done.
export MSBUILDDISABLENODEREUSE=1
# @ECLASS_VARIABLE: DOTNET_NOLOGO
# @DESCRIPTION:
# Disables the header logo when running dotnet commands.
export DOTNET_NOLOGO=1

# Needed otherwise the binaries break
RESTRICT+=" strip"

# @ECLASS_VARIABLE: NUGETS
# @DEFAULT_UNSET
# @PRE_INHERIT
# @DESCRIPTION:
# bash string containing all nuget package wants to download
# used by nuget_uris()
# Example:
# @CODE
# NUGETS="
# ImGui.NET-1.87.2
# Config.Net-4.19.0
# "
# inherit nuget
# ...
# SRC_URI="$(nuget_uris)"
# @CODE

# @FUNCTION: nuget_uris
# @DESCRIPTION:
# Generates the URIs to put in SRC_URI to help fetch dependencies.
# Uses first argument as nuget list.
# If no argument provided, uses NUGETS variable.
nuget_uris() {
	local -r regex='^([a-zA-Z0-9_.-]+)-([0-9]+\.[0-9]+\.[0-9]+.*)$'
	local nuget nugets

	if [[ -n ${@} ]]; then
		nugets="$@"
	elif [[ -n ${NUGETS} ]]; then
		nugets="${NUGETS}"
	else
		eerror "NUGETS variable is not defined and nothing passed as argument"
		die "Can't generate SRC_URI from empty input"
	fi

	for nuget in ${nugets}; do
		local name version url
		[[ $nuget =~ $regex ]] || die "Could not parse name and version from nuget: $nuget"
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
	case "${ARCH}" in
		*amd64)
			DOTNET_RUNTIME="linux-x64"
			;;
		*arm)
			DOTNET_RUNTIME="linux-arm"
			;;
		*arm64)
			DOTNET_RUNTIME="linux-arm64"
			;;
		*)
			die "Unsupported arch: ${ARCH}"
			;;
	esac

	for _dotnet in dotnet-{${DOTNET_SLOT},bin-${DOTNET_SLOT}}; do
		if type $_dotnet 1> /dev/null 2>&1; then
			DOTNET_EXECUTABLE=$_dotnet
			break
		fi
	done
}

# @FUNCTION: edotnet
# @USAGE: [[command] <args> ...]
# @DESCRIPTION:
# Call dotnet, passing the supplied arguments.
# @RETURN: dotnet exit code
edotnet() {
	debug-print-function ${FUNCNAME} "$@"

	local ret

	set -- "$DOTNET_EXECUTABLE" "${@}" --runtime "${DOTNET_RUNTIME}" -maxcpucount:$(makeopts_jobs)
	echo "${@}" >&2
	"${@}"
	ret=${?}

	if [[ ${ret} -ne 0 ]]; then
		die -n "edotnet failed"
	fi

	return ${ret}
}

# @FUNCTION: dotnet-utils_src_unpack
# @DESCRIPTION:
# Unpacks the package
dotnet-utils_src_unpack() {
	debug-print-function ${FUNCNAME} "$@"

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
# Restores the packages

dotnet-utils_src_prepare() {
	debug-print-function ${FUNCNAME} "$@"
	edotnet restore \
		--source "${DISTDIR}" || die
	default
}

# @FUNCTION: dotnet-utils_src_compile
# @DESCRIPTION:
# Build the package using dotnet publish
dotnet-utils_src_compile() {
	debug-print-function ${FUNCNAME} "$@"

	edotnet publish \
		--no-restore \
		--configuration Release \
		"-p:Version=${PV}" \
		-p:DebugType=embedded \
		--self-contained || die
}
