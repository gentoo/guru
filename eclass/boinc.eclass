# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# @ECLASS: boinc.eclass
# @MAINTAINER:
# Anna Vyalkova <cyber+gentoo@sysrq.in>
# @SUPPORTED_EAPIS: 8
# @BLURB: An eclass to build BOINC applications and libraries.
# @DESCRIPTION:
# This eclass provides helper functions to build BOINC applications and libraries.

inherit toolchain-funcs

case ${EAPI} in
	8) ;;
	*) die "${ECLASS}: EAPI ${EAPI} unsupported."
esac

# @ECLASS-VARIABLE: BOINC_SUBMODULE
# @PRE_INHERIT
# @DEFAULT_UNSET
# @DESCRIPTION:
# Set this variable to a subdirectory relative to BOINC source repository,
# if software cannot be built outside it (for example, if some required
# headers are missing in sci-misc/boinc).
#
# If unset, no functions will be exported.

# @ECLASS-VARIABLE: BOINC_S
# @DEFAULT_UNSET
# @DESCRIPTION:
# If defined this variable determines the source directory name after
# unpacking. This defaults to package name and version. Note that this
# variable supports a wildcard mechanism to help with github tarballs
# that contain the commit hash as part of the directory name.

if [[ ${BOINC_SUBMODULE} ]]; then
	EXPORT_FUNCTIONS src_unpack src_prepare src_configure
fi

if [[ ! ${_BOINC_ECLASS} ]]; then

# @FUNCTION: get_boinc_src
# @USAGE: <SRC_URI|S> <release> [client|server]
# @RETURN: SRC_URI snippet or temporary build directory for given BOINC release
get_boinc_src() {
	local query_var=${1}
	local RELEASE_PATCH=${2}
	local RELEASE_MINOR=$(ver_cut 1-2 ${RELEASE_PATCH})
	local RELEASE_TYPE=${3:-client}

	local SUFFIX=
	case ${RELEASE_TYPE} in
		server) SUFFIX="-server" ;;
		client) ;;
		*) die "${FUNCNAME}: unknown release type '${RELEASE_TYPE}'"
	esac

	local _SRC_URI="https://github.com/BOINC/boinc/archive"
	_SRC_URI+="${RELEASE_TYPE}_release/${RELEASE_MINOR}/${RELEASE_PATCH}.tar.gz"
	_SRC_URI+=" -> boinc${SUFFIX}-${RELEASE_PATCH}.tar.gz"

	local _S="${WORKDIR}/boinc-${RELEASE_TYPE}_release-${RELEASE_MINOR}-${RELEASE_PATCH}"

	case ${query_var} in
		SRC_URI) echo "${_SRC_URI}" ;;
		S) echo "${_S}" ;;
		*) die "${FUNCNAME}: unknown variable to query (${query_var})"
	esac

}

# @ECLASS-VARIABLE: BOINC_BUILD_DIR
# @OUTPUT_VARIABLE
# @DESCRIPTION:
# Temporary build directory, where BOINC sources are located.

# @FUNCTION: boinc_require_source
# @USAGE: [boinc version] [client|server]
# @DESCRIPTION:
# Set up SRC_URI and S for building application within BOINC source tree.
#
# This function must be called in global scope, after BOINC_SUBMODULE
# and SRC_URI have been declared. Take care not to overwrite the variables
# set by it.
#
# If no BOINC version is given, this function assumes it equal to client
# release $PV.
boinc_require_source() {
	local boinc_version=${1:-${PV}}
	SRC_URI+=" $(get_boinc_src SRC_URI ${boinc_version} ${2})"

	readonly BOINC_BUILD_DIR="$(get_boinc_src S ${boinc_version} ${2})"
	S="${BOINC_BUILD_DIR}/${BOINC_SUBMODULE}"
}

# @FUNCTION: boinc_enable_autotools
# @USAGE: [econf args...]
# @DESCRIPTION:
# Configure BOINC source tree using autotools.
#
# If no arguments are given, econf will be called
# with --enable-pkg-devel flag.
#
# This function must be called in global scope.
boinc_enable_autotools() {
	inherit autotools
	_BOINC_RUN_AUTOTOOLS=1
	_BOINC_ECONF_ARGS=${@:---enable-pkg-devel}
}

# @FUNCTION: boinc_override_config
# @USAGE: <config.h>
# @DESCRIPTION:
# Some applications do not need autotools to build but
# use a few HAVE_* defines.

# If you want to save ~40 seconds and really know what
# to do, pass prepared config.h to this function.
#
# This function must be called in global scope.
boinc_override_config() {
	_BOINC_CONFIG_OVERRIDE="${1}"
}

# @FUNCTION: boinc_builddir_check
# @USAGE:
# @DESCRIPTION:
# Make sure BOINC_BUILD_DIR has a value.
boinc_builddir_check() {
	if [[ ! ${BOINC_BUILD_DIR} ]]; then
		eerror "BOINC_BUILD_DIR is not set."
		die "Did you forget to call boinc_require_source?"
	fi

	mkdir -p ${BOINC_BUILD_DIR} || die
}

boinc_src_unpack() {
	default_src_unpack
	boinc_builddir_check

	[[ -d ${S} ]] && \
		return

	# Special case, for the always-lovely GitHub fetches. With this,
	# we allow the star glob to just expand to whatever directory it's
	# called.
	if [[ "${BOINC_S:=${P}}" = *"*"* ]]; then
		pushd "${WORKDIR}" >/dev/null || die
		local shopt_save=$(shopt -p nullglob)
		shopt -s nullglob

		# use an array to trigger filename expansion
		BOINC_S=( ${BOINC_S} )
		if [[ ${#BOINC_S[@]} -gt 1 ]]; then
			die "BOINC_S did expand to multiple paths: ${BOINC_S[*]}"
		fi

		${shopt_save}
		popd >/dev/null || die
	fi

	mkdir -p "$(dirname "${S}")" || die
	mv "${WORKDIR}/${BOINC_S}" "${S}" || die
}

boinc_src_prepare() {
	boinc_builddir_check
	default_src_prepare

	if [[ ${_BOINC_RUN_AUTOTOOLS} ]]; then
		pushd "${BOINC_BUILD_DIR}" >/dev/null || die
		eautoreconf
		popd >/dev/null || die
	fi
}

boinc_src_configure() {
	boinc_builddir_check
	pushd "${BOINC_BUILD_DIR}" >/dev/null || die

	bash ./generate_svn_version.sh || \
		die "generating svn_version.h failed"

	if [[ ${_BOINC_RUN_AUTOTOOLS} ]]; then
		econf "${_BOINC_ECONF_ARGS[@]}"
	else
		tc-export AR CC CPP CXX LD OBJDUMP RANLIB
	fi

	if [[ ${_BOINC_CONFIG_OVERRIDE} ]]; then
		cp "${_BOINC_CONFIG_OVERRIDE}" config.h || die
	fi

	popd >/dev/null || die
}

_BOINC_ECLASS=1
fi
