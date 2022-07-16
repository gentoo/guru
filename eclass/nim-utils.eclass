# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# @ECLASS: nim-utils.eclass
# @MAINTAINER:
# Anna Vyalkova <cyber+gentoo@sysrq.in>
# @AUTHOR:
# Anna Vyalkova <cyber+gentoo@sysrq.in>
# @SUPPORTED_EAPIS: 8
# @BLURB: utility functions for Nim packages
# @DESCRIPTION:
# A utility eclass providing functions to call and configure Nim.
#
# This eclass does not set any metadata variables nor export any phase
# functions. It can be inherited safely.

case ${EAPI} in
	8) ;;
	*) die "${ECLASS}: EAPI ${EAPI} unsupported."
esac

if [[ ! ${_NIM_UTILS_ECLASS} ]]; then

# @ECLASS_VARIABLE: NIMFLAGS
# @USER_VARIABLE
# @DEFAULT_UNSET
# @DESCRIPTION:
# Flags for the Nim compiler.

# @ECLASS_VARIABLE: TESTAMENT_DISABLE_MEGATEST
# @USER_VARIABLE
# @DEFAULT_UNSET
# @DESCRIPTION:
# If set, pass '--megatest:off' to testament.

# @VARIABLE: ETESTAMENT_DESELECT
# @DEFAULT_UNSET
# @DESCRIPTION:
# Specifies an array of test files to be deselected via testament's --skipFrom
# parameter, when calling etestament.

inherit multiprocessing toolchain-funcs xdg-utils

# @FUNCTION: enim
# @USAGE: [<args>...]
# @DESCRIPTION:
# Call nim, passing the supplied arguments.
# This function dies if nim fails. It also supports being called via 'nonfatal'.
# If you need to call nim directly in your ebuilds, this is the way it should
# be done.
enim() {
	debug-print-function ${FUNCNAME} "${@}"

	set -- nim "${@}"
	echo "$@" >&2
	"$@" || die -n "${*} failed"
}

# @FUNCTION: etestament
# @USAGE: [<args>...]
# @DESCRIPTION:
# Call testament, passing the supplied arguments.
# This function dies if testament fails.
etestament() {
	debug-print-function ${FUNCNAME} "${@}"

	local -a testament_args=()
	[[ ${TESTAMENT_DISABLE_MEGATEST} ]] && \
		testament_args+=( --megatest:off )

	[[ "${NOCOLOR}" == true || "${NOCOLOR}" == yes ]] && \
		testament_args+=( --colors:off )

	if [[ ${ETESTAMENT_DESELECT} ]]; then
		local skipfile="${T}"/testament.skipfile
		if [[ ! -f ${skipfile} ]]; then
			for t in "${ETESTAMENT_DESELECT[@]}"; do
				echo "${t}" >> "${skipfile}"
			done
		fi
		testament_args+=( --skipFrom:"${skipfile}" )
	fi

	set -- testament "${testament_args[@]}" "${@}"
	echo "$@" >&2
	"$@" || die -n "${*} failed"
}

# @FUNCTION: nim_gen_config
# @USAGE:
# @DESCRIPTION:
# Generate the ${WORKDIR}/nim.cfg to respect user's toolchain and preferences.
nim_gen_config() {
	debug-print-function ${FUNCNAME} "${@}"

	xdg_environment_reset

	cat > "${WORKDIR}/nim.cfg" <<- EOF || die "Failed to create Nim config"
	cc:"gcc"
	gcc.exe:"$(tc-getCC)"
	gcc.linkerexe:"$(tc-getCC)"
	gcc.cpp.exe:"$(tc-getCXX)"
	gcc.cpp.linkerexe:"$(tc-getCXX)"
	gcc.options.speed:"${CFLAGS}"
	gcc.options.size:"${CFLAGS}"
	gcc.options.debug:"${CFLAGS}"
	gcc.options.always:"${CPPFLAGS}"
	gcc.options.linker:"${LDFLAGS}"
	gcc.cpp.options.speed:"${CXXFLAGS}"
	gcc.cpp.options.size:"${CXXFLAGS}"
	gcc.cpp.options.debug:"${CXXFLAGS}"
	gcc.cpp.options.always:"${CPPFLAGS}"
	gcc.cpp.options.linker:"${LDFLAGS}"

	$([[ "${NOCOLOR}" == true || "${NOCOLOR}" == yes ]] && echo '--colors:"off"')
	-d:"release"
	--parallelBuild:"$(makeopts_jobs)"
	$(printf "%s\n" ${NIMFLAGS})
	EOF
}

_NIM_UTILS_ECLASS=1
fi
